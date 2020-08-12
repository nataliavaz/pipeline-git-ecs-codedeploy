provider "aws" {
  region  = var.region
  version = "~> 3.00"
}

terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "terraform-remotestate-5b1aee268a18fbec"
    key    = "repositorios.tfstate"
    region = "us-east-1"
  }
}

locals {
  tags = {
    Terraform   = "True"
    Environment = var.environment
  }
}

