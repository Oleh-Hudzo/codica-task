############################
#     AWS Configuration    #
############################

variable "region" {
  default =  "eu-central-1"
}

variable "default_az" {
  default =  "eu-central-1a"
}

variable "profile" {           // Profile must be generated beforehand through the AWS Console (with at least programmatic access)
  default = "codica_task"
}

############################
#          Naming          #
############################ 

variable "default_tag" {
  default = "codica"
}

############################
#           SSH            #
############################

variable "ssh_user" {
  default = "ubuntu"
}

variable "ssh_key_name" {        // The ssh key pair must be generated beforehand through the AWS Console
  default = "server-key-pair"
}

variable "ssh_key_path" {
  default = "~/.ssh/server-key-pair.pem"
}

############################
#            RDS           #
############################

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

variable "db_name" {             // Ensure that the database authentication credentials are identical 
  default = "wordpress"          // to those in the docker-compose.yaml file in the ansible/playbook folder
}

variable "db_user" {             // Ensure that the database authentication credentials are identical
  default = "wpuser"             // to those in the docker-compose.yaml file in the ansible/playbook folder
}

variable "db_password" {         // Ensure that the database authentication credentials are identical
  default = "CODICAexample"      // to those in the docker-compose.yaml file in the ansible/playbook folder
}

############################
#            EC2           #
############################ 
variable "ec2_instance_type" {
  default = "t3.micro"
}
