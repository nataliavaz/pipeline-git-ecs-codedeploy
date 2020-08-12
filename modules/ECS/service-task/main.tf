
resource "aws_ecs_task_definition" "task" {
  family                   = var.application
  execution_role_arn       = module.ECSTaskExecution_IAM.arn //var.execution_role_arn
  task_role_arn            = module.ECSTaskExecution_IAM.arn //var.execution_role_arn
  requires_compatibilities = var.launch_type
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_mem

  container_definitions = templatefile("${path.module}/../../../templates/template-fargate.json",
    {
      app_image      = var.app_image
      container_name = var.application
      protocol       = var.container_protocol
      app_port       = var.app_port
      aws_region     = var.region
  })

  depends_on = [module.ECSTaskExecution_IAM, aws_iam_role_policy_attachment.attach_role_task]
}

data "aws_ecs_task_definition" "task" {
  task_definition = aws_ecs_task_definition.task.family

  depends_on = [aws_ecs_task_definition.task]
}

resource "aws_ecs_service" "service" {
  name = var.application
  //task_definition                   = aws_ecs_task_definition.task.family
  task_definition                   = "${aws_ecs_task_definition.task.family}:${max("${aws_ecs_task_definition.task.revision}", "${data.aws_ecs_task_definition.task.revision}")}"
  cluster                           = var.cluster_id
  desired_count                     = var.desired_count
  launch_type                       = "FARGATE"
  platform_version                  = var.platform_version
  health_check_grace_period_seconds = 5

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer_conf
    content {
      target_group_arn = lookup(load_balancer.value, "target_group_arn")
      container_name   = lookup(load_balancer.value, "container_name")
      container_port   = lookup(load_balancer.value, "container_port")
    }
  }

  lifecycle {
    ignore_changes = [task_definition, load_balancer]
  }

}

