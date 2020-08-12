resource "aws_codepipeline" "pipeline" {
  name     = var.application
  role_arn = module.Codepipeline-IAM.arn
  tags     = var.tags

  artifact_store {
    location = var.artifact_store
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceCode"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source-${var.application}"]

      configuration = {
        RepositoryName = var.repository_codecommit
        BranchName     = "master"
      }
    }

    action {
      name             = "SourceImage"
      category         = "Source"
      owner            = "AWS"
      provider         = "ECR"
      output_artifacts = ["imagem-${var.application}"]
      version          = "1"

      configuration = {
        RepositoryName = var.repository_ecr
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeployToECS"
      input_artifacts = ["source-${var.application}", "imagem-${var.application}"]
      version         = "1"

      configuration = {
        ApplicationName                = var.codedeploy_app
        DeploymentGroupName            = var.codeploy_deploymentgroup
        TaskDefinitionTemplateArtifact = "source-${var.application}"
        TaskDefinitionTemplatePath     = "taskdef.json"
        AppSpecTemplateArtifact        = "source-${var.application}"
        AppSpecTemplatePath            = "appspec.yml"
        Image1ArtifactName             = "imagem-${var.application}"
        Image1ContainerName            = "IMAGE1_NAME"
      }
    }
  }
}

resource "aws_cloudwatch_event_rule" "rule_codecommit" {
  name        = "codepipeline-codecommit-${var.application}"
  description = "Evento para iniciar automaticamente o pipeline quando houver alteração no repositório do CodeCommit"

  event_pattern = templatefile("${path.module}/../../templates/codecommit.json",
    {
      repository_arn = var.repository_codecommit_arn
  })

}

resource "aws_cloudwatch_event_target" "target_codecommit" {
  rule     = aws_cloudwatch_event_rule.rule_codecommit.name
  arn      = aws_codepipeline.pipeline.arn
  role_arn = module.Codepipeline-Codecommit-IAM.arn
}

resource "aws_cloudwatch_event_rule" "rule_ecr" {
  name        = "codepipeline-ecr-${var.application}"
  description = "Evento para iniciar automaticamente o pipeline quando houver alteração no repositório do ECR"

  event_pattern = templatefile("${path.module}/../../templates/ecr.json",
    {
      repository_name = var.repository_ecr
  })
}

resource "aws_cloudwatch_event_target" "target_ecr" {
  rule     = aws_cloudwatch_event_rule.rule_ecr.name
  arn      = aws_codepipeline.pipeline.arn
  role_arn = module.Codepipeline-Codecommit-IAM.arn
}