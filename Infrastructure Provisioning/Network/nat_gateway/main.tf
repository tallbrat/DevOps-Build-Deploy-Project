// To create Elastic IP for each subnet in all Availability Zone.
locals {
  public_subnets = {
    for index, subnet_id in values(module.subnets["public_subnets_for_${var.availability_zones[count.index]}"]) : index => subnet_id
  }
}

resource "aws_eip" "nat_eip" {
    count   = length(module.subnet["private_subnets_for_${var.availability_zones[count.index]}"])
    domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw" {
  for_each        = local.public_subnets
  subnet_id       = each.value
  allocation_id   = aws_eip.nat_eip[count.index].id
}



//Code Dump
/* count           = length(module.subnets["public_subnets_for_${var.availability_zones[count.index]}"])  # Adjust the module and output name accordingly
resource "aws_nat_gateway" "nat_gw" {
    count               = length(var.availability_zones)
    subnet_id           = { for index in var.public_subnet_ids : subnet if var.}
    allocation_id       = aws_eip.nat_eip[count.index].id
}
variable "public_subnet_ids" {
  type = string
  default = module.
}
locals {
  number-of-private-subnet-key = module.subnets.public_subnets_for_(${var.availability_zones})
}
*/