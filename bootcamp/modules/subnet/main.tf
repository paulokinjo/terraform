resource "aws_subnet" "bootcamp-subnet-1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name : "${var.env_prefix}-subnet-1"
  }
}

resource "aws_internet_gateway" "bootcamp-igw" {
  vpc_id = var.vpc_id

  tags = {
    Name : "${var.env_prefix}-igw"
  }
}

resource "aws_route_table" "bootcamp-route-table" {
  vpc_id = var.vpc_id

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