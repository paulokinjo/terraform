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

variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "env_prefix" {}
variable "instance_type" {}
variable "public_key_location" {}

resource "aws_vpc" "bootcamp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "bootcamp-subnet-1" {
  vpc_id            = aws_vpc.bootcamp-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = format("%s%s", data.aws_region.default.name, "a")

  tags = {
    Name : "${var.env_prefix}-subnet-1"
  }
}

resource "aws_internet_gateway" "bootcamp-igw" {
  vpc_id = aws_vpc.bootcamp-vpc.id

  tags = {
    Name : "${var.env_prefix}-igw"
  }
}

resource "aws_route_table" "bootcamp-route-table" {
  vpc_id = aws_vpc.bootcamp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bootcamp-igw.id
  }

  tags = {
    Name : "${var.env_prefix}-rtb"
  }
}

resource "aws_route_table_association" "bootcamp-rtb-subnet" {
  subnet_id      = aws_subnet.bootcamp-subnet-1.id
  route_table_id = aws_route_table.bootcamp-route-table.id
}

resource "aws_security_group" "bootcamp-sg" {
  name   = "bootcamp-sg"
  vpc_id = aws_vpc.bootcamp-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name : "${var.env_prefix}-sg"
  }
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

/* output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image.id
} */

resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.env_prefix}-server-key-pair"
  public_key = file(var.public_key_location)
}

resource "aws_instance" "bootcamp-server" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  subnet_id              = aws_subnet.bootcamp-subnet-1.id
  vpc_security_group_ids = [aws_security_group.bootcamp-sg.id]
  availability_zone      = format("%s%s", data.aws_region.default.name, "a")

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")

  tags = {
    Name : "${var.env_prefix}-server"
  }
}

output "ec2_public_ip" {
  value = aws_instance.bootcamp-server.public_ip
}