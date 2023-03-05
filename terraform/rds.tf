# RDS configuration

## Placing RDS in private subnet
resource "aws_db_subnet_group" "this" {
  name       = "${var.default_tag}-sng-rds"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_b.id]

  tags = {
    Name = "${var.default_tag}-sng-rds"
  }
}

## Creating RDS instance
resource "aws_db_instance" "wordpress_rds" {
  instance_class         = var.db_instance_class
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  parameter_group_name   = var.db_parameter_group_name

  identifier             = "${var.default_tag}-rds"

  storage_type           = "gp2"  // Can be change based on purpose
  allocated_storage      = 20     // Can be change based on purpose
  max_allocated_storage  = 0      // Can be change based on purpose
  
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
  db_name                = "wordpress"
  username               = var.db_user
  password               = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  availability_zone      = var.default_az

  tags = {
    Name = "${var.default_tag}-rds"
  }
}
