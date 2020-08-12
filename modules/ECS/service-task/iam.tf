module "ECSTaskExecution_IAM" {
  source = "../../IAM/role-policy"
  tags   = var.tags

  name    = "ecs-task-execution-${var.application}"
  service = "ecs-tasks.amazonaws.com"
  policy  = var.policy_task_execution
}

resource "aws_iam_role_policy_attachment" "attach_role_task" {
  role       = module.ECSTaskExecution_IAM.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}