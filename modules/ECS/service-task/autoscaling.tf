module "autoscaling" {
  source    = "../AutoScaling"
  tags      = var.tags
  aplicacao = var.application
  //ecs_autoscale_role = module.IAM_ECSAutoScale.arn

  max_tasks         = var.max_tasks
  min_tasks         = var.desired_count
  cluster_name      = var.cluster_name
  service_name      = aws_ecs_service.service.name
  cpu_to_scale_up   = 80
  cpu_to_scale_down = 20
}