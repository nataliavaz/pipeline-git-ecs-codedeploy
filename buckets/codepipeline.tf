module "bucket_codepipeline" {
  source     = "../modules/S3"
  name       = "bucket-codepipeline-${random_id.id.hex}"
  versioning = true

  tags = {
    Name      = "Bucket CodePipeline"
    Terraform = "True"
  }

}

resource "aws_s3_bucket_policy" "policy_pipeline" {
  bucket = module.bucket_codepipeline.name

  policy = templatefile("../templates/policy_s3_codepipeline.json",
    {
      bucket_name = module.bucket_codepipeline.name
      account_id  = data.aws_caller_identity.current.account_id
  })
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = module.bucket_codepipeline.name

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
