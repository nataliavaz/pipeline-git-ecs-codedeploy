provider "aws" {
  region  = var.region
  version = "~> 2.70"
}

terraform {
  backend "s3" {
    bucket = "terraform-remotestate-5b1aee268a18fbec"
    key    = "vpc.tfstate"
    region = "us-east-1"
  }

}

locals {
  tags = {
    Name      = "vpc-${var.environment}"
    Ambiente  = var.environment
    Terraform = "True"
  }
}

module "vpc" {
  source      = "../modules/VPC"
  cidr        = var.cidr
  tags        = local.tags
  region      = var.region
  environment = var.environment

  create_database_subnet_group           = false
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true
  create_elasticache_subnet_route_table  = true
  one_nat_gateway_per_az                 = false
  enable_nat_gateway                     = false
  single_nat_gateway                     = true
  enable_vpn_gateway                     = false
  enable_dns_hostnames                   = true
  enable_dns_support                     = true
  enable_s3_endpoint                     = false
  enable_dynamodb_endpoint               = false
}
