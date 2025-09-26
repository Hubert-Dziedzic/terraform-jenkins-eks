variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "Subnet CIDR for private subnet"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnet CIDR for public subnet"
  type        = list(string)
}

