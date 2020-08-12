module "bucket-cloudfront" {
  source     = "../modules/S3"
  name       = "${var.frontend_url}"
  acl        = "private"
  versioning = true

  tags = {
    Name      = "Bucket Cloudfront"
    Terraform = "True"
  }

}

resource "aws_s3_bucket_policy" "bucket-cloudfront" {
  bucket = module.bucket-cloudfront.name

  policy = templatefile("../templates/policy_s3_cloudfront.json",
    {
      bucket_name     = module.bucket-cloudfront.name
      account_id      = data.aws_caller_identity.current.account_id
      access_identity = aws_cloudfront_origin_access_identity.identity_teste.iam_arn
  })
}

resource "aws_s3_bucket_public_access_block" "bucket-cloudfront" {
  bucket = module.bucket-cloudfront.name

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
