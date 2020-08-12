module "service" {
  source = "./services"

  region              = var.region
  bucket_codepipeline = var.bucket_codepipeline
  bucket_codebuild    = var.bucket_codebuild
  tags                = local.tags
  alb_dns_name        = aws_lb.alb.dns_name
  alb_zone_id         = aws_lb.alb.zone_id
  alb_name            = aws_lb.alb.name
  sg_lb_id            = module.sg_lb_ecs.id
  zone_id             = data.aws_route53_zone.main.id
  health_check_path   = "/health"

  //ECS
  service           = var.service
  url_service       = var.url_service
  app_port          = var.app_port
  task_cpu_app      = 512
  task_mem_app      = 1024
  desired_count_app = 1
  max_tasks_app     = 3
  ecr_uri           = data.terraform_remote_state.repositorios.outputs.ecr_uri
  subnets           = ["${data.terraform_remote_state.vpc.outputs.public_subnets[0]}", "${data.terraform_remote_state.vpc.outputs.public_subnets[1]}", "${data.terraform_remote_state.vpc.outputs.public_subnets[2]}"]
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  ecs_cluster_name  = aws_ecs_cluster.cluster.name
  ecs_cluster_id    = aws_ecs_cluster.cluster.id
  listener_prod     = module.listener_443.arn
  listener_test     = module.listener_4443.arn
  policy_task       = templatefile("../templates/policy_task_execution_service.json", {})

  //CodeDeploy
  action_on_timeout                = "CONTINUE_DEPLOYMENT" //"CONTINUE_DEPLOYMENT, STOP_DEPLOYMENT"
  wait_time_in_minutes             = 0
  action_on_deployment_success     = "TERMINATE"
  termination_wait_time_in_minutes = 5
  deployment_config_name           = "CodeDeployDefault.ECSAllAtOnce"

  //Codebuild
  git_token = var.git_token
  git_repos = var.git_repos
  buildspec = templatefile("../templates/buildspec.yml", {
    repository_uri  = data.terraform_remote_state.repositorios.outputs.ecr_uri

  })
  ecr_arn   = data.terraform_remote_state.repositorios.outputs.ecr_arn

  //Pipeline
  ecr_name        = data.terraform_remote_state.repositorios.outputs.ecr_name
  codecommit_arn  = data.terraform_remote_state.repositorios.outputs.codecommit_arn
  codecommit_name = data.terraform_remote_state.repositorios.outputs.codecommit_name
}