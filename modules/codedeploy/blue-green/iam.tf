module "IAM_CodedeployECS" {
  source = "../../IAM/role-awspolicy"
  tags   = var.tags

  name       = "codedeploy-ecs-${var.application}"
  service    = "codedeploy.amazonaws.com"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}