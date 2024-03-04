#public routing
locals {
  public_subnet = {
    for index, subenet_id in values(module.subnet["public_subnets_for_${var.availability_zones [count.index]}"]) : index => subnet_id
  }
}

resource "aws_route_table" "public" {
  count  = var.number-of-public-subnet
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block            = "0.0.0.0/0"
    gateway_id            = module.internet_gateway.igw_id
  }

  dynamic "subnet_association" {
    for_each          = local.public_subnet
    content {
      subnet_id       = each.value
      route_table_id  = aws_route_table.public[count.index / var.number-of-public-subnet].id
    }
  }
}

#private routing
locals {
  private_subnet = {
    for index, subenet_id in values(module.subnet["private_subnets_for_${var.availability_zones [count.index]}"]) : index => subnet_id
  }
}
resource "aws_route_table" "private" {
  count  = var.number-of-private-subnet
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block      = module.my_vpc.cidr_block
    gateway_id      = module.nat_gateway.nat_gateway_ids[count.index]
  }

  dynamic "subnet_association" {
    for_each         = local.private_subnet

    content {
      subnet_id      = each.value
      route_table_id = aws_route_table.private[count.index].id
    }
  }
}

/*
#public routing
resource "aws_route_table" "public" {
  count  = var.number-of-public-subnet
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block            = "0.0.0.0/0"
    gateway_id            = module.internet_gateway.igw_id
  }

  dynamic "subnet_association" {
    for_each          = [
      for subnet in var.subnet_names : subnet
      if substr(my_subnet.tags["name"], length(my_subnet.tags["name"]) -1)] <= "${var.req-pub-sub}"

    content {
      subnet_id       = subnet_association.key
      route_table_id  = aws_route_table.public[count.index / var.req-pub-sub].id
    }
  }
}

#private routing
resource "aws_route_table" "private" {
  count  = var.req-priv-sub
  vpc_id = var.vpc_id

  route {
    cidr_block      = aws_vpc.test.cidr_block
    gateway_id      = var.nat_gateway_ids[count.index] 
  }

  dynamic "subnet_association" {
    for_each = [for subnet_id in var.subnet_ids : subnet_id if subnet_id != element(aws_route_table.public[count.index].subnet_association[*].subnet_id, count.index)]

    content {
      subnet_id      = subnet_association.value
      route_table_id = aws_route_table.private[count.index].id
    }
  }
}

*/