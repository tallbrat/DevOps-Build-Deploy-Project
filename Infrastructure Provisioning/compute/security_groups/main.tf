
resource "aws_security_group" "public_sg" {
  for_each    = {for obj in var.no-of-public-instance-in-each-tier : obj.tier => obj}

  name        = "${each.key}"
  description = "Security group for public instances in subnet ${each.key}"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = var.common_ingress_rules

    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = [for sg in aws_security_group.public_sg : sg.id if sg.name == each.key]
      description     = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.common_egress_rules

    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      security_groups  = [for sg in aws_security_group.public_sg : sg.id if sg.name == each.key]
      description      = egress.value.description
    }
  }
}

resource "aws_security_group" "private_sg" {
  for_each    = { for obj in var.no-of-private-instance-in-each-tier : obj.tier => obj }

  name        = "private-instance-sg-${each.key}"
  description = "Security group for private instances in subnet ${each.key}"
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = each.key== "app" ? var.ingress_rules_app : var.ingress_rules_db
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = [for sg in aws_security_group.private_sg : sg.id if sg.name == each.key]
      description     = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = var.common_egress_rules

    content {
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidr_blocks
      security_groups = [for sg in aws_security_group.public_sg : sg.id if sg.name == each.key]
      description     = egress.value.description
    }
  }
}
