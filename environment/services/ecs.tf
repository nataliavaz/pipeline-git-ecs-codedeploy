module "ecs" {
  source      = "../../modules/ECS/service-task"
  tags        = var.tags
  application = var.service

  //Task
  task_cpu              = var.task_cpu_app
  task_mem              = var.task_mem_app
  policy_task_execution = var.policy_task
  app_image             = var.ecr_uri
  app_port              = var.app_port
  container_protocol    = "tcp"
  platform_version      = "1.4.0"
  region                = var.region

  load_balancer_conf = [
    {
      target_group_arn = module.tg_blue.arn
      container_name   = var.service
      container_port   = var.app_port
    }
  ]

  //Service
  desired_count   = var.desired_count_app
  max_tasks       = var.max_tasks_app
  subnets         = var.subnets
  security_groups = module.sg_ecs_app.id
  cluster_id      = var.ecs_cluster_id
  cluster_name    = var.ecs_cluster_name
}