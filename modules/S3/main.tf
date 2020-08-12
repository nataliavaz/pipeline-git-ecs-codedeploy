resource "aws_s3_bucket" "this" {

  bucket = var.name
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  tags = var.tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


