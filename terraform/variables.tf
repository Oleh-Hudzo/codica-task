############################
#     AWS Configuration    #
############################

variable "region" {
  default =  "eu-central-1"
  description = "The AWS region in which resources will be created"
}

variable "default_az" {
  default =  "eu-central-1a"
  description = "The default availability zone to use when creating resources"
}

variable "profile" {           // Profile must be generated beforehand through the AWS Console (with at least programmatic access)
  default = "codica_task"
  description = "The AWS CLI profile to use when authenticating with AWS. This must be generated beforehand through the AWS Console with at least programmatic access"
}

variable "cidr_block" {
  default = "10.10.0.0/16"
  description = "VPC cidr block"
}

############################
#          Naming          #
############################ 

variable "default_tag" {
  default = "codica"
  description = "A default tag to be applied to resources created by this module"
}

############################
#           SSH            #
############################

variable "ssh_user" {
  default = "ubuntu"
  description = "The default user to use when SSHing into instances created by this module"
}

variable "ssh_key_name" {        // The ssh key pair must be generated beforehand through the AWS Console
  default = "server-key-pair"
  description = "The name of the SSH key pair that will be used to connect to instances created by this module. The key pair must be generated beforehand through the AWS Console"
}

variable "ssh_key_path" {
  default = "~/.ssh/server-key-pair.pem"
  description = "The local path to the private key of the SSH key pair"
}

############################
#            RDS           #
############################

variable "db_instance_class" {
  default = "db.t3.micro"
  description = "The instance class for the RDS instance"
}

variable "db_engine" {
  default = "mysql"
  description = "The database engine for the RDS instance"
}

variable "db_engine_version" {
  default = "5.7.38"
  description = "The version of the database engine to use for the RDS instance"
}

variable "db_parameter_group_name" {
  default = "default.mysql5.7"
  description = "The name of the database parameter group to use for the RDS instance"
}

variable "db_name" {                                      // Ensure that the database authentication credentials are identical 
  default = "wordpress"                                   // to those in the docker-compose.yaml file in the ansible/playbook folder
  description = "The name of the WordPress database"          
}

variable "db_user" {                                      // Ensure that the database authentication credentials are identical
  default = "wpuser"                                      // to those in the docker-compose.yaml file in the ansible/playbook folder
  description = "The username for the WordPress database"
}

variable "db_password" {                                  // Ensure that the database authentication credentials are identical
  default = "CODICAexample"                               // to those in the docker-compose.yaml file in the ansible/playbook folder
  description = "The password for the WordPress database"
}

############################
#            EC2           #
############################ 
variable "ec2_instance_type" {
  default = "t3.micro"
  description = "The EC2 instance type for the WordPress application servers."
}
