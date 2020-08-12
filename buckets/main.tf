provider "aws" {
  region  = var.region
  version = "~> 3.00"
}
terraform {
  backend "s3" {
    bucket  = "terraform-remotestate-5b1aee268a18fbec"
    key     = "s3.tfstate"
    region  = "us-east-1"
    encrypt = "true"
  }
}

locals {
  tags = {
    Terraform = "True"
  }
}

data "aws_caller_identity" "current" {}

resource "random_id" "id" {
  byte_length = 8
}