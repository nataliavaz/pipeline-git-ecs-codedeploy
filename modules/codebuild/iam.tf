module "codebuild_IAM" {
  source = "../IAM/role-policy"
  tags   = var.tags

  name    = "codebuild-${var.application}"
  service = "codebuild.amazonaws.com"
  policy  = var.policy
}