output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "vpc_cidr_prefix" {
  value = "${join(".", slice(split(".", var.vpc_cidr), 0, 2))}."
}