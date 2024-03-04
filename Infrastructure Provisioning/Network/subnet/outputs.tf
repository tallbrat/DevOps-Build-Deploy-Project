output "subnet_id" {
  value = aws_subnet.my_subnet[*].id
}

output "subnet_names" {
  value = aws_subnet.my_subnet[*].tags["Name"]
}
output "cidr_block" {
  value = aws_subnet.my_subnet.cidr_block
}


/*
output "public_subnet_ids" {
  value = [for subnet in aws_subnet.my_subnet : subnet.id if starts_with(subnet.tags["Name"], "public")]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.my_subnet : subnet.id if starts_with(subnet.tags["Name"], "private")]
}
output "public_subnet_ids_by_az" {
  value = {
    for az in var.availability_zones : az => [for subnet in aws_subnet.my_subnet : subnet.id if starts_with(subnet.tags["Name"], "public") && subnet.availability_zone == az]
  }
}

output "private_subnet_ids_by_az" {
  value = {
    for az in var.availability_zones : az => [for subnet in aws_subnet.my_subnet : subnet.id if starts_with(subnet.tags["Name"], "private") && subnet.availability_zone == az]
  }
} */

output "public_subnets_for_$${element(var.availability_zones, count.index / var.subnets_per_az)}" {
  value = [for subnet in aws_subnet.my_subnet : subnet.id 
    if starts_with(subnet.tags["Name"], "public")
    && subnet.availability_zone == element(var.availability_zones, count.index / var.subnets_per_az)]
}

output "private_subnets_for_$${element(var.availability_zones, count.index / var.subnets_per_az)}" {
    value = [for subnet in aws_subnet.my_subnet : subnet.id
    if starts_with(subnet.tags["Name"], "private") 
    && subnet.availability_zone == element(var.availability_zones, count.index / var.subnets_per_az)]
  }
