module "Codepipeline-IAM" {
  source = "../IAM/role-policy"
  tags   = var.tags

  name    = "codepipeline-codedeploy-ecs-${var.application}"
  service = "codepipeline.amazonaws.com"
  policy = templatefile("${path.module}/../../templates/policy_codepipeline.json", {
    resource_arn = var.resource_passrole
  })

}

module "Codepipeline-Codecommit-IAM" {
  source = "../IAM/role-policy"
  tags   = var.tags

  name    = "start-pipeline-${var.application}"
  service = "events.amazonaws.com"

  policy = templatefile("${path.module}/../../templates/policy_start_pipeline_exec.json",
    {
      resource_arn = aws_codepipeline.pipeline.arn
  })
}

