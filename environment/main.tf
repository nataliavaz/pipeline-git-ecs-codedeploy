provider "aws" {
  region  = var.region
  version = "~> 3.0"
}

provider "aws" {
  alias   = "us"
  region  = "us-east-1"
  version = "~> 3.1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-remotestate-5b1aee268a18fbec"
    key            = "environment.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

locals {
  tags = {
    Terraform   = "True",
    Environment = var.environment
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = var.environment
  tags = local.tags

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

