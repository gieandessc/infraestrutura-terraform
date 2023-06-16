terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "sa-east-1"
  default_tags {
    tags = {
      owner      = "sgieand"
      managed-by = "terraform"
    }
  }
}