variable "cidr_blocks" {
  description = "cidr blocks for vpc and subnets"
  type = list(object({
    name       = string
    cidr_block = string
  }))
}

variable "vpc_cidr_block" {
  type        = string
  description = "vpc cidr block"
}

variable "subnet_cidr_block" {
  type        = string
  description = "subnet cidr block"
}