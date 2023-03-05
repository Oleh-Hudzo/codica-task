# VPC
resource "aws_vpc" "wp-vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "${var.default_tag}-vpc"
  }
}

# Public subnets
resource "aws_subnet" "sn_public_a" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 1)
  availability_zone       = "${var.region}a"

  tags = {
    Name = "sn-public-a-${var.default_tag}"
  }
}

resource "aws_subnet" "sn_public_b" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 2)
  availability_zone       = "${var.region}b"

  tags = {
    Name = "sn-public-b-${var.default_tag}"
  }
}

#Private subnets
resource "aws_subnet" "sn_private_a" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 3)
  availability_zone       = "${var.region}a"

  tags = {
    Name = "sn-private-a-${var.default_tag}"
  }
}

resource "aws_subnet" "sn_private_b" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 4)
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "sn-private-b-${var.default_tag}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.wp-vpc.id

  tags = {
    Name = "${var.default_tag}-igw"
  }
}

# Elastic IP for NAT
resource "aws_eip" "nat" {
  vpc = true
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.sn_public_a.id

  tags = {
    Name = "${var.default_tag}-nat-gw"
  }

  depends_on = [aws_internet_gateway.default]
}

# Route Tables
## Public
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.wp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "${var.default_tag}-rt-public"
  }
}

## Associate route table with public subnets
resource "aws_route_table_association" "rt_public_a" {
  subnet_id      = aws_subnet.sn_public_a.id
  route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "rt_public_b" {
  subnet_id      = aws_subnet.sn_public_b.id
  route_table_id = aws_route_table.rt_public.id
}

## Private
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.wp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.default_tag}-rt-private"
  }
}

## Associate route table with private subnets
resource "aws_route_table_association" "private_nat_rt_a" {
  subnet_id      = aws_subnet.sn_private_a.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "private_nat_rt_b" {
  subnet_id      = aws_subnet.sn_private_b.id
  route_table_id = aws_route_table.rt_private.id
}
