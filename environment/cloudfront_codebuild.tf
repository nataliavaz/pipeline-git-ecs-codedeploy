module "codebuild" {
  source = "../modules/codebuild/"

  log_retention = 30

  policy = templatefile("../templates/policy_codebuild_cloudfront.json", {
    log_group   = var.application
    bucket_name = module.bucket-cloudfront.name
    cloudfront  = module.cloudfront.arn
  })

  application  = var.application
  git_token    = var.git_cf_token
  git_repos    = var.git_cf_repos
  cache_bucket = "${var.bucket_codebuild}/frontend"

  buildspec = templatefile("../templates/buildspec_cloudfront.yml",
    {
      node_version = 12
  })

  tags = local.tags

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