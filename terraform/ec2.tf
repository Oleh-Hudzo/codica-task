# Check for latest Ubuntu ami
data "aws_ami" "latest-ubuntu-image" {
    most_recent = true
    owners = ["099720109477"]
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
}

/* Check for latest Amazon Linux 2 ami (just an option for further tasks)
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
*/

# AWS EC2 instance
resource "aws_instance" "wp-instance" {
  ami                         = data.aws_ami.latest-ubuntu-image.id
  instance_type               = var.ec2_instance_type
  key_name                    = var.ssh_key_name
  vpc_security_group_ids      = [aws_security_group.sg_web.id]
  subnet_id                   = aws_subnet.sn_public_a.id
  associate_public_ip_address = true
  monitoring                  = true

  tags = {
    Name = "${var.default_tag}-ec2"
  }
}

# Provisioning with Ansible
resource "null_resource" "configure_server" {
  depends_on = [
    aws_db_instance.wp-db-instance
  ]

  provisioner "local-exec" {
    working_dir = "../ansible/"
    command = "ansible-playbook --inventory ${aws_instance.wp-instance.public_ip}, --private-key ${var.ssh_key_path} --user ubuntu playbooks/wordpress-deploy.yaml"
  }
    /* Provisioner for Amazon Linux 2 instance
    provisioner "local-exec" {
    working_dir = "../ansible/"
    command = "ansible-playbook --inventory ${aws_instance.wp-instance.public_ip}, --private-key ${var.ssh_key_path} --user ubuntu playbooks/wordpress-deploy.yaml"
  }
    */
}
