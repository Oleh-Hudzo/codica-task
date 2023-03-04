# Route Table
## Public (Default)
resource "aws_default_route_table" "rt_public" {
  default_route_table_id = aws_vpc.wp-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "${var.default_tag}-rt-public"
  }
}

resource "aws_route_table_association" "rt_public_a" {
  subnet_id      = aws_subnet.sn_public_a.id
  route_table_id = aws_vpc.wp-vpc.default_route_table_id
}

resource "aws_route_table_association" "rt_public_b" {
  subnet_id      = aws_subnet.sn_public_b.id
  route_table_id = aws_vpc.wp-vpc.default_route_table_id
}

## Private
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.wp-vpc.id

  tags = {
    Name = "${var.default_tag}-rt-private"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.sn_public_a.id

  tags = {
    Name = "${var.default_tag}-nat-gw"
  }
}

# Route Table with NAT
resource "aws_route_table" "private_nat_rt" {
  vpc_id = aws_vpc.wp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.default_tag}-rt-private-nat"
  }
}

# Associate route table with private subnets
resource "aws_route_table_association" "private_nat_rt_a" {
  subnet_id      = aws_subnet.sn_private_a.id
  route_table_id = aws_route_table.private_nat_rt.id
}

resource "aws_route_table_association" "private_nat_rt_b" {
  subnet_id      = aws_subnet.sn_private_b.id
  route_table_id = aws_route_table.private_nat_rt.id
}
