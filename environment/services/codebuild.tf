
module "codebuild" {
  source = "../../modules/codebuild/"

  log_retention = 30

  policy = templatefile("${path.module}/../../templates/policy_codebuild.json", {
    ecr_repos = var.ecr_arn
    log_group = var.service
  })

  application  = var.service
  git_token    = var.git_token
  git_repos    = var.git_repos
  cache_bucket = "${var.bucket_codebuild}/${var.service}"

  buildspec = var.buildspec
  tags      = var.tags

  create_webhook = true

  filter_rule = [
    {
      type    = "EVENT"
      pattern = "PUSH"
    },
    {
      type    = "HEAD_REF"
      pattern = "master"
    }
  ]
}