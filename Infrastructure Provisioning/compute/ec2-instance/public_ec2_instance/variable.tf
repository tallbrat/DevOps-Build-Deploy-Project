

variable "ami_id" {}
variable "instance_type" {}
variable "no-of-public-instance-in-each-tier" {}  // from sg output. Define it as glocal (variable) 
variable "availability_zones" {}

variable "additional_public_instance_tags" {
  description = "Additional tags to be applied to the public EC2 instances."
  # No type or default specified here
}                                                  // from here. Define if as global variable

variable "public-root-volume-size" {
  description = "Define root volume of the EC2 instanc2 where operating system is installed."
}                                                    // from here. Define it as global Variable

variable "key_name" {}