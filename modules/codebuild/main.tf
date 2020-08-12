resource "aws_cloudwatch_log_group" "codebuild" {
  name              = "/codebuild/${var.application}"
  retention_in_days = var.log_retention

  tags = merge({ Name = "codebuild-${var.application}-log-group" }, var.tags)
}

resource "aws_codebuild_source_credential" "this" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = var.git_token
}

resource "aws_codebuild_project" "this" {
  name          = var.application
  description   = "Build - ${var.application}"
  build_timeout = "15"
  service_role  = module.codebuild_IAM.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = var.cache_bucket
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codebuild.name
      stream_name = ""
    }
  }

  source {
    type      = "GITHUB"
    location  = var.git_repos
    buildspec = var.buildspec

    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = false
    }

    auth {
      resource = aws_codebuild_source_credential.this.id
      type     = "OAUTH"
    }

  }

  source_version = "master"

  tags = var.tags

}


