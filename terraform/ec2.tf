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
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
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

data "aws_ami" "latest-amazon-linux-image" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}

resource "aws_instance" "wp-instance" {
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = var.ec2_instance_type
  key_name                    = var.ssh_key_name
  subnet_id                   = aws_subnet.sn_public_a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg_web.id]
  monitoring                  = true

  tags = {
    Name = "${var.default_tag}-ec2"
    TargetGroup = "wp-instance-tg"
  }
}

resource "null_resource" "configure_server" {
  triggers = {
    trigger = aws_instance.wp-instance.public_ip
  }

  provisioner "local-exec" {
    working_dir = "../ansible/"
    command = "ansible-playbook --inventory ${aws_instance.wp-instance.public_ip}, --private-key ${var.ssh_key_path} --user ec2-user playbooks/wordpress-deploy.yaml --extra-vars \"rds_endpoint=$(terraform output rds_endpoint)\""
  }
}
