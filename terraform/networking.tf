# Internet Gateway
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.wp-vpc.id

  tags = {
    Name = "${var.default_tag}-igw"
  }
}

# Elastic IP
resource "aws_eip" "nat_eip" {
  vpc = true
}
/*
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.wp-instance.id
  allocation_id = aws_eip.wp_eip.id
}
*/
