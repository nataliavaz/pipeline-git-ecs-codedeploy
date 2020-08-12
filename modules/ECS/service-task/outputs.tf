output "service_name" {
  value = aws_ecs_service.service.name
}

output "service_arn" {
  value = aws_ecs_service.service.id
}

output "task_role_arn" {
  value = module.ECSTaskExecution_IAM.arn
}
