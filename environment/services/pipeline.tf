module "pipeline" {
  source = "../../modules/pipeline-ecs-codedeploy"
  tags   = var.tags

  artifact_store            = var.bucket_codepipeline
  application               = var.service
  repository_codecommit     = var.codecommit_name
  repository_ecr            = var.ecr_name
  codedeploy_app            = aws_codedeploy_app.app.name
  codeploy_deploymentgroup  = module.deployment_group.name
  repository_codecommit_arn = var.codecommit_arn
  resource_passrole         = module.ecs.task_role_arn
}
