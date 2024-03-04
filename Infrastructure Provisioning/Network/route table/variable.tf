#global variable
variable "number-of-public-subnet" {
    type = string
}                                           //from subnet main define it as global (variable)

variable "number-of-private-subnet" {
  type = string
}                                           //from subnet main define it as global (variable)

variable "availability_zones" {} 

/*
variable "nat_gateway_ids" {
  
}
variable "igw_id" {}
variable "vpc_id" {}
variable "subnet_ids" {
    type = list(string)
}
variable "subnet_name" {}
variable "cidr_block" {}

*/