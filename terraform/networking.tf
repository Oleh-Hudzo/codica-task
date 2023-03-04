# Internet Gateway
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.wp-vpc.id

  tags = {
    Name = "${var.default_tag}-igw"
  }
}

# Elastic IP
resource "aws_eip" "wp_eip" {
  vpc = true
}
/*
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.wp-instance.id
  allocation_id = aws_eip.wp_eip.id
}
*/
# Create NAT Gateway
resource "aws_nat_gateway" "wp-nat" {
  allocation_id = aws_eip.wp_eip.id
  subnet_id     = aws_subnet.sn_public_a.id
}
