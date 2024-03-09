resource "aws_subnet" "my_subnet  " {
  vpc_id            = module.vpc.vpc_id
  count             = var.subnets_per_az
  cidr_block        = "${module.vpc.vpc_cidr_prefix}${count.index + 1}.0/24"
  availability_zone = element(var.availability_zones, count.index / var.subnets_per_az)
  tags = {
    Name = "${var.subnet_type[count.index / var.number-of-private-subnet]}-subnet-${var.availability_zones[count.index / var.subnets_per_az]}-${count.index % var.subnets_per_az + 1}"
  }
}


/*
resource "aws_subnet" "my_subnet" {
  vpc_id            = var.vpc_id
  count             = length(var.availability_zones) * var.subnets_per_az
  cidr_block        = "${var.vpc_cidr_prefix}${count.index + 1}.0/24"
  availability_zone = element(var.availability_zones, count.index / var.subnets_per_az)
  tags = {
    Name = "${var.subnet_type[count.index / var.number-of-public-subnet]}-subnet-${var.availability_zones[count.index / var.subnets_per_az]}-${count.index % var.subnets_per_az + 1}"
  }
}
*/

