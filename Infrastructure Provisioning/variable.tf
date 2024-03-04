variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type    = list(string)
  # Define a list of availability zones
}

variable "subnets_per_az" {
  type    = number
  # Define the number of subnets per availability zone
}

variable "number-of-public-subnet" {
  type = number
  # Define the number of public subnet in an availability zone
}

variable "number-of-private-subnet" {
  type = number
  # Define the number of private subnet in an availability zone
}

#Public Secruity Gateway
variable "no-of-public-instance-in-each-tier" {
  type = object({
    tier = string
    count = number
  })
}

variable "common_ingress_rules" {
  description = "Common ingress rules for security groups"
  type        = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = string
  }))
}

variable "common_egress_rules" {
  description = "Common egress rules for security groups"
  type        = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = string
  }))
}
#Private Secruity Gateway
variable "no-of-private-instance-in-each-tier" {
  type = object({
    tier = string
    count = number
  })                  # Define a list of tier you want in an availability zone.
}
variable "ingress_rules_app" {
  description = "Common ingress rules for security groups"
  type        = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = string
  }))
}

variable "egress_rules_app" {
  description = "Common egress rules for security groups"
  type        = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = string
  }))
}

variable "ingress_rules_db" {
  description = "Common ingress rules for security groups"
  type        = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = string
  }))
}

variable "egress_rules_db" {
  description = "Common egress rules for security groups"
  type        = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    description      = string
  }))
}

variable "key_name" {
  type = string
}
variable "key_name" {
  
}
#Instances
variable "number-of-instance-in-web" {
  type = number
}
variable "number-of-instance-in-app" {
  type = number
}
variable "number-of-instance-in-db" {
  type = number
}
variable "no-of-private-instance-in-each-tier" {
  type = object({
    tier = string
    count = number
  })                  # Define a list of tier you want in an availability zone.
}

variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "additional_private_instance_tags" {
  type        = map(string)
  default     = {}
}                                                  // from here. Define if as global variable

variable "additional_public_instance_tags" {
  type        = map(string)
  default     = {}
}    
variable "public-root-volume-size" {
  type = number
  default = 0
}
variable "private-root-volume-size" {
  type = number
  default = 0
}

