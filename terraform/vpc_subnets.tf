# Public subnets
resource "aws_subnet" "sn_public_a" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "sn-public-a-${var.default_tag}"
  }
}

resource "aws_subnet" "sn_public_b" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "sn-public-b-${var.default_tag}"
  }
}

#Private subnets
resource "aws_subnet" "sn_private_a" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "sn-private-a-${var.default_tag}"
  }
}

resource "aws_subnet" "sn_private_b" {
  vpc_id                  = aws_vpc.wp-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false

  tags = {
    Name = "sn-private-b-${var.default_tag}"
  }
}
