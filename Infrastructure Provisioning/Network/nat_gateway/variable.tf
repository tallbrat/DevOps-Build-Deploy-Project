variable "availability_zones" {} //from vpc module.Define it as global (variable)


# Unused Variables

//variable "public_subnet_ids" {} //from subnet outputs (module)
//variable "number-of-public-subnet" {} //from subnet main define it as global (variable)
//variable "number-of-private-subnet" {} //from here. Define it as gobal (variable)
//variable "number-of-nat_gateway" {} //from here. Define it as gobal (variable)

//variable "private_subnets_for_$${element(var.availability_zones, count.index / var.subnets_per_az)}" {} //From Subnet output. Define it as (module)