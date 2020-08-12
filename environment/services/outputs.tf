output "endpoint_app" {
  value = aws_route53_record.app.name
}

output "tg_blue_arn" {
  value = module.tg_blue.arn
}

output "tg_green_arn" {
  value = module.tg_green.arn
}

output "sg_app" {
  value = module.sg_ecs_app.id
}