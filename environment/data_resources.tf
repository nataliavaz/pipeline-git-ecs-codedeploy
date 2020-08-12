data "aws_route53_zone" "main" {
  name         = var.domain
  private_zone = false
}

data "aws_caller_identity" "current" {}

data "aws_acm_certificate" "acm" {
  domain      = var.domain
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

data "terraform_remote_state" "repositorios" {
  backend = "s3"
  config = {
    bucket = var.bucket_remote_state
    key    = "repositorios.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.bucket_remote_state
    key    = "vpc.tfstate"
    region = var.region
  }
}