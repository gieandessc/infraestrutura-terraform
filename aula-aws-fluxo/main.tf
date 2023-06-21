
terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.4.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

locals {
  container_name = "bff-fargate-ecs-container"
  container_port = 8081 # ! Must be same port from our Dockerfile that we EXPOSE
  example        = "bff-fargate-ecs-cluster"
}

provider "aws" {
  region = "sa-east-1"
  default_tags {
    tags = {
      owner      = "sgieand"
      managed-by = "terraform"
      example    = local.example
    }
  }
}

# * Give Docker permission to pusher Docker images to AWS
data "aws_caller_identity" "this" {}
data "aws_ecr_authorization_token" "this" {}
data "aws_region" "this" {}
locals { ecr_address = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.this.name) }
provider "docker" {
  registry_auth {
    address  = local.ecr_address
    password = data.aws_ecr_authorization_token.this.password
    username = data.aws_ecr_authorization_token.this.user_name
  }
}