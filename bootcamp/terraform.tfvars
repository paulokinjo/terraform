vpc_cidr_block    = "10.0.0.0/16"
subnet_cidr_block = "10.0.10.0/24"
cidr_blocks = [
  {
    name       = "vpc",
    cidr_block = "10.0.0.0/16"
  },
  {
    name       = "subnet",
    cidr_block = "10.0.10.0/24"
  }
]