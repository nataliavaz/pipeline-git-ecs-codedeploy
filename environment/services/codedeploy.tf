resource "aws_codedeploy_app" "app" {
  compute_platform = "ECS"
  name             = var.service
}

module "deployment_group" {
  source = "../../modules/codedeploy/blue-green"
  tags   = var.tags

  app_name                         = aws_codedeploy_app.app.name
  application                      = var.service
  listener_prod                    = var.listener_prod
  listener_test                    = var.listener_test
  tg_blue                          = module.tg_blue.name
  tg_green                         = module.tg_green.name
  ecs_cluster_name                 = var.ecs_cluster_name
  ecs_service_name                 = module.ecs.service_name
  action_on_timeout                = var.action_on_timeout
  wait_time_in_minutes             = var.wait_time_in_minutes
  action_on_deployment_success     = var.action_on_deployment_success
  termination_wait_time_in_minutes = var.termination_wait_time_in_minutes
  deployment_config_name           = var.deployment_config_name
}