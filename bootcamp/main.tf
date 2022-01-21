terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0"
  /* backend "s3" {
    bucket = "some-aws-bucket-name"
    key    = "bootcamp/state.tfstate"
    region = "ap-northeast-1"
  } */
}

# Configure the AWS Provider
provider "aws" {}
data "aws_region" "default" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "bootcamp-vpc"
  cidr = var.vpc_cidr_block

  azs = [format("%s%s", data.aws_region.default.name, "a")]

  public_subnets = [var.subnet_cidr_block]
  public_subnet_tags = {
    Name = "${var.env_prefix}-subnet-1"
  }

  tags = {
    Name        = "${var.env_prefix}-vpc"
    Terraform   = "true"
    Environment = "dev"
  }
}

/* resource "aws_vpc" "bootcamp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
} */

/* module "bootcamp-subnet" {
  source            = "./modules/subnet"
  cidr_block        = var.subnet_cidr_block
  env_prefix        = var.env_prefix
  vpc_id            = aws_vpc.bootcamp-vpc.id
  availability_zone = format("%s%s", data.aws_region.default.name, "a")
} */

module "bootcamp-webserver" {
  source              = "./modules/webserver"
  env_prefix          = var.env_prefix
  vpc_id              = module.vpc.vpc_id
  availability_zone   = format("%s%s", data.aws_region.default.name, "a")
  instance_type       = var.instance_type
  public_key_location = var.public_key_location
  subnet_id           = module.vpc.public_subnets[0]
}