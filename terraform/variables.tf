# Credentials
variable "region" {
  default =  "eu-central-1"
}

variable "default_az" {
  default =  "eu-central-1a"
}

variable "profile" {
  default = "codica_task"
}

# Naming
variable "default_tag" {
  default = "codica"
}

# SSH
variable "ssh_user" {
  default = "ec2-user"
}

variable "ssh_key_name" {
  default = "server-key-pair"
}

variable "ssh_key_path" {
  default = "~/.ssh/server-key-pair.pem"
}

# RDS
variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_engine" {
  default = "mysql"
}

variable "db_engine_version" {
  default = "5.7.38"
}

variable "db_parameter_group_name" {
  default = "default.mysql5.7"
}

variable "db_name" {
  default = "wordpress"
}

variable "db_user" {
  default = "wpuser"
}

variable "db_password" {
  default = "CODICAexample"
}

# EC2
variable "ec2_instance_type" {
  default = "t3.micro"
}
