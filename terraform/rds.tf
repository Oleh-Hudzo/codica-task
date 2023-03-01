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

resource "aws_db_subnet_group" "default" {
  name       = "${var.default_tag}-sng-rds"
  subnet_ids = [aws_subnet.sn_private_a.id, aws_subnet.sn_private_b.id]

  tags = {
    Name = "${var.default_tag}-sng-rds"
  }
}

resource "aws_db_instance" "wp-db-instance" {
  instance_class         = var.db_instance_class
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  parameter_group_name   = var.db_parameter_group_name

  identifier             = "${var.default_tag}-rds"

  storage_type           = "gp2"
  allocated_storage      = 20
  max_allocated_storage  = 0
  
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  db_name                = "wordpress"
  username               = var.db_user
  password               = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  availability_zone      = var.default_az

  tags = {
    Name = "${var.default_tag}-rds"
  }
}
