provider "aws" {
  region  = var.region
  version = "~> 3.00"
}

resource "random_id" "id" {
  byte_length = 8
}

module "bucket" {
  source     = "../../modules/S3"
  name       = "terraform-remotestate-${random_id.id.hex}"
  versioning = var.versioning

  tags = {
    "Name"      = "Bucket Remote State Terraform"
    "Env"       = var.environment
    "Terraform" = "True"
  }

}

resource "aws_s3_bucket_policy" "basic_policy" {
  bucket = module.bucket.name

  policy = templatefile("../../templates/policy_s3_basic.json",
    {
      bucket_name = module.bucket.name
  })
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = module.bucket.name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}