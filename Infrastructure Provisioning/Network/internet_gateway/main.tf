resource "aws_internet_gateway" "my_igw" {
  vpc_id = module.aws_vpc.vpc_id
}
