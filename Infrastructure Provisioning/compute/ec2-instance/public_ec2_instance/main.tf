

resource "aws_instance" "public_instances" {
  for_each        = {for obj in var.no-of-public-instance-in-each-tier : obj.tier => obj.count}
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = {
    for index, subenet_id in values(module.subnet["public_subnets_for_${var.availability_zones [count.index]}"]) : index => subnet_id
  }
  security_groups = module.security_groups.public_security_group_ids[count.index]
  key_name        = var.key_name
  associate_public_ip_address = yes

  root_block_device {
    volume_size = var.public-root-volume-size
    volume_type = "gp2"
  }

  tags = merge(
    {
      Name = "private-instance-${each.key}-${count.index + 1}"
      tier = "${each.key}"
    },
    var.additional_public_instance_tags
  )
}
