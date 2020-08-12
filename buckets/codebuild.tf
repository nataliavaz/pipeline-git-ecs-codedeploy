module "bucket_codebuild" {
  source     = "../modules/S3"
  name       = "bucket-codebuild-cache-${random_id.id.hex}"
  versioning = true

  tags = {
    Name      = "Bucket Codebuild"
    Terraform = "True"
  }

}

resource "aws_s3_bucket_policy" "bucket_codebuild" {
  bucket = module.bucket_codebuild.name

  policy = templatefile("../templates/policy_s3_basic.json",
    {
      bucket_name = module.bucket_codebuild.name
  })
}

resource "aws_s3_bucket_public_access_block" "bucket_codebuild" {
  bucket = module.bucket_codebuild.name

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

