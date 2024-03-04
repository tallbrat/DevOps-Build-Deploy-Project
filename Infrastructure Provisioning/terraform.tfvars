vpc_cidr = "10.0.0.0/16"
# Specify the desired vpc cidr value

availability_zones = ["us-west-1a"]
# Specify the availability zones you want to use

subnets_per_az = 2
# Specify the number of subnets per availability zone

number-of-public-subnet = 1
# Specify the number of public subnets per availability zone

number-of-private-subnet = 1
# Specify the number of priate subnets per availability zone


# Public Secruity Gateway
common_ingress_rules = [
  {
    from_port        = [80, 443, 22, 8080]
    to_port          = [80, 443, 22, 8080]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow HTTP, HTTPS, SSH, Jenkins traffic from anywhere"
  }
]

common_egress_rules = [
  {
    from_port        = [80, 443, 22, 8080]
    to_port          = [80, 443, 22, 8080]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow HTTP, HTTPS, SSH, Jenkins traffic from anywhere"
  }
]

#Private Secruity Gateway
ingress_rules_app = [
  {
    from_port        = [22, 80, 443,6443,8001, 10250]
    to_port          = [22, 80, 443,6443,8001, 10250]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow SSH, HTTP and HTTPS traffic from anywhere"
  },
  {
    from_port        = 30000
    to_port          = 32767
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all kubernete ports traffic from anywhere"
  }
]

egress_rules_app = [
  {
    from_port        = [22, 80, 443,6443,8001, 10250]
    to_port          = [22, 80, 443,6443,8001, 10250]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow SSH, HTTP and HTTPS traffic from anywhere"
  },
  {
    from_port        = 230000
    to_port          = 32767
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all kubernete ports traffic from anywhere"
  }
]

#Key Pair
key_name = "one_key"

#Instances
no-of-public-instance-in-each-tier = [ {web = 1} ]
#Specify the number of instance in each tier

no-of-private-instance-in-each-tier = [ {app = 1} ]
#Specify the number of instance in each tier

additional_private_instance_tags = {
  server = "kube-server"
}

additional_public_instance_tags = {
  server = "jenkins-server"
}

public-root-volume-size = 30 # Volume size of 30GB for 