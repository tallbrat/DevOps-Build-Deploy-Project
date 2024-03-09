//variable "vpc_id" {}
variable "availability_zones" {}
//variable "vpc_id" {}
variable "subnets_per_az" {}
//variable "vpc_cidr_prefix" {
  //type    = string
//}
variable "subnet_type" {
  type    = list(string)
  default = [ "private", "public" ]
}
variable "number-of-private-subnet" {}  //from subnet-global-(variable)