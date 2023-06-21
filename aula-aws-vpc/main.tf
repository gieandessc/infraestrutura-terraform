
terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.4.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
  default_tags {
    tags = {
      owner      = "sgieand"
      managed-by = "terraform"
    }
  }
}

resource "aws_vpc" "main_tf" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "main_subnet_1_tf" {
  vpc_id     = aws_vpc.main_tf.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PUBLIC 1"
  }
}

resource "aws_subnet" "main_subnet_2_tf" {
  vpc_id     = aws_vpc.main_tf.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "PUBLIC 2"
  }
}