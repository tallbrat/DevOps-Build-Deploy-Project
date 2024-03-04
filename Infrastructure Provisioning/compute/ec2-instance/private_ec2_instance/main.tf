
resource "aws_instance" "private_instances" {
  for_each        = {for obj in var.no-of-private-instance-in-each-tier : obj.tier => obj.count}
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = {
    for index, subenet_id in values(module.subnet["private_subnets_for_${var.availability_zones [count.index]}"]) : index => subnet_id
  }
  security_groups = {
    for index, sg_id in values (module.security_groups["private_sg_ids_${element(keys(var.no-of-private-instance-in-each-tier), count.index)}"]) : index => sg_id
  }
 key_name        = var.key_name

  root_block_device {
    volume_size = var.private-root-volume-size
    volume_type = "gp2"
  }

  tags = merge(
    {
      Name = "private-instance-${each.key}-${count.index + 1}"
      tier = "${each.key}"
    },
    var.additional_private_instance_tags
  )
}


/*
resource "aws_instance" "private_instances" {
  count         = length(var.private_subnet_ids)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_ids[count.index]
  
  tags = {
    Name = "private-instance-${count.index + 1}"
  }
}
*/
