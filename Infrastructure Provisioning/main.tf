provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source   = "./Network/vpc"
  vpc_cidr = var.vpc_cidr
}

module "internet_gateway" {
  source = "./Network/internet_gateway"
}

module "subnets" {
  source              = "./Network/subnets"
  availability_zones  = var.availability_zones
  subnets_per_az      = var.subnets_per_az
}

module "nat_gateway" {
  source              = "./Network/nat_gateway"
  availability_zones  = var.availability_zones
}

module "route_table" {
  source                      = "./Network/route table"
  availability_zones          = var.availability_zones
  number-of-private-subnet    = var.number-of-private-subnet
  number-of-public-subnet     =  var.number-of-public-subnet
}
module "security_groups" {
  source                              = "./compute/security_groups"
  no-of-public-instance-in-each-tier  = var.no-of-public-instance-in-each-tier
  no-of-private-instance-in-each-tier = var.no-of-private-instance-in-each-tier
}

# Key Pain
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits = 4096
}
resource "aws_key_pair" "key_pair" {
  key_name = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

#Save PEM file locally
resource "local_file" "private_key_pem" {
  filename = var.key_name
  content = tls_private_key.rsa_4096.private_key_openssh
  
  provisioner "local-exec" {
    command = "chmod 400 ${var.key_name}"
  }
}

# Instances
## Public Instance
module "public_ec2_instance" {
  source                              = "./compute/ec2-instance/public_ec2_instance"
  availability_zones                  = var.availability_zones
  ami_id                              = var.ami_id
  instance_type                       = var.instance_type
  no-of-public-instance-in-each-tier  = var.no-of-public-instance-in-each-tier
  additional_public_instance_tags     = var.additional_public_instance_tags
  public-root-volume-size             = var.public-root-volume-size
  key_name                            = aws_key_pair.key_pair.key_name            
}

## If you dont have Ansible installed on your machine, connect to the ec2_instance using
## connection and execute inline command for tools to be installed using remote-exec
/*
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.rsa_4096.private_key_pem
  }
  provisioner "remote-exec" {
    inline = [
      #Install Ansible to the instance
      "sudo apt update",
      "sudo apt -y install software-properties-common",
      "sudo apt-add-repository ppa:ansible/ansible",
      "sudo apt install ansible",
      "sudo apt install python3-pip -y",
      "sudo pip3 install boto boto3"
    ]
  }
*/

## If you have Ansible installed in your machine use this method.
# Generate dynamic inventory for Ansible
data "template_file" "inventory" {
  depends_on = [module.public_ec2_instance]
  template = <<-EOT
    [web_servers]
    ${module.public_ec2_instance.public_ip} ansible_user=ubuntu ansible_private_key_file=${path.module}/${var.key_name}
    # Add other instances as needed
  EOT
}
#save the inventory template to dynamic_inventory.ini in local
resource "local_file" "dynamic_inventory" {
  depends_on = [data.template_file.inventory, module.public_ec2_instance]

  filename = "dynamic_inventory.ini"
  content  = data.template_file.inventory.rendered

  provisioner "local-exec" {
    command = "chmod 400 ${local_file.dynamic_inventory.filename}"
  }
}
# Run Ansible playbook after infrastructure provisioning
resource "null_resource" "run_ansible" {
  depends_on = [local_file.dynamic_inventory]

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/dynamic_inventory.ini all_tools_jenkins-server.yml"
    working_dir = path.module
  }
}

## Private Instance
module "private_ec2_instance" {
  source                              = "./compute/ec2-instance/private_ec2_instance"
  availability_zones                  = var.availability_zones
  ami_id                              = var.ami_id
  instance_type                       = var.instance_type
  no-of-private-instance-in-each-tier = var.no-of-private-instance-in-each-tier
  additional_private_instance_tags    = var.additional_public_instance_tags
  private-root-volume-size            = var.private-root-volume-size
  key_name                            = aws_key_pair.key_pair.key_name
}

## If you have Ansible installed in your machine use this method.
# Generate dynamic inventory for Ansible
data "template_file" "inventory2" {
  depends_on = [module.public_ec2_instance]
  template = <<-EOT
    [web_servers]
    ${module.private_ec2_instance.public_ip} ansible_user=ubuntu ansible_private_key_file=${path.module}/${var.key_name}
    # Add other instances as needed
  EOT
}
#Append the inventory template to old_dynamic_inventory.ini in local

resource "null_resource" "dynamic_inventory2" {
  depends_on = [data.template_file.inventory2, module.private_ec2_instance]

  # Execute a local command to append content to the file
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory2.rendered}' >> ${path.module}/dynamic_inventory.ini"
  }
}

#save the inventory template to dynamic_inventory.ini in local
resource "local_file" "dynamic_inventory2" {
  depends_on = [data.template_file.inventory2, module.private_ec2_instance]

  filename = "dynamic_inventory.ini"
  content  = data.template_file.inventory2.rendered

  provisioner "local-exec" {
    command = "chmod 400 ${local_file.dynamic_inventory2.filename}"
  }
}

# Run Ansible playbook after infrastructure provisioning
resource "null_resource" "run_ansible" {
  depends_on = [null_resource.dynamic_inventory2]

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/dynamic_inventory.ini all_tools_k8s-server.yml"
    working_dir = path.module
  }
}