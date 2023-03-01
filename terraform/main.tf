terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

# VPC
resource "aws_vpc" "wp-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "${var.default_tag}-vpc"
  }
}
