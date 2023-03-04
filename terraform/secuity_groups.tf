#Security groups

## Security group for AWS EC2 instance
resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "Security Group Web"
  vpc_id      = aws_vpc.wp-vpc.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  /* We don't have SSL or TLS sertificate, so we can let the 443 port be closed
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  */

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.default_tag}-sg-web"
  }
}


## Security group for RDS instance
resource "aws_security_group" "sg_rds" {
  name        = "sg_rds"
  description = "Security Group RDS"
  vpc_id      = aws_vpc.wp-vpc.id

  ingress {
    description      = "MYSQL/Aurora"
    from_port        = 3306
    to_port          = 3306
    protocol         = "TCP"
    security_groups  = ["${aws_security_group.sg_web.id}"]
  }

  tags = {
    Name = "${var.default_tag}-sg-rds"
  }
}
