terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {}
data "aws_region" "default" {}



resource "aws_vpc" "dev-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    Name : var.cidr_blocks[0].name
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = var.cidr_blocks[1].cidr_block
  availability_zone = format("%s%s", data.aws_region.default.name, "a")

  tags = {
    Name : var.cidr_blocks[1].name
  }
}