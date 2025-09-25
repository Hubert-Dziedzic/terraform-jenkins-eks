variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet" {
  description = "Subnet CIDR for public subnet"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}