variable "no-of-public-instance-in-each-tier" {}
variable "no-of-private-instance-in-each-tier" {}

variable "common_ingress_rules" {
  type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
  }))
  default = []
}

variable "common_egress_rules" {
  type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
  }))
  default = []
}

variable "ingress_rules_app" {
    type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
  }))
  default = []
}
variable "egress_rules_app" {
    type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
  }))
  default = []
}

variable "ingress_rules_db" {
    type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
  }))
  default = []
}
variable "egress_rules_db" {
    type = list(object({
    description      = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
  }))
  default = []
}

