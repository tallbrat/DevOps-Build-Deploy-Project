

variable "ami_id" {}
variable "instance_type" {}

variable "availability_zones" {}
variable "no-of-private-instance-in-each-tier" {} // from sg output. Define it as global (variable) 

variable "additional_private_instance_tags" {
  description = "Additional tags to be applied to the private EC2 instances."
  # No type or default specified here
}                                                  // from here. Define it as global variable

variable "private-root-volume-size" {
  description = "Define root volume of the EC2 instanc2 where operating system is installed."
}                                                    // from here. Define it as global Variable

variable "key_name" {}


/*
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "vpc_id" {}
*/