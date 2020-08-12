module "tg_blue" {
  source = "../../modules/LB/target_group"

  name        = "tg-${var.service}-blue"
  tags        = var.tags
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check_defaults = {
    health_check_interval            = var.health_check_interval
    health_check_path                = var.health_check_path
    health_check_port                = var.health_check_port
    health_check_healthy_threshold   = var.health_check_healthy_threshold
    health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
    health_check_timeout             = var.health_check_timeout
    health_check_protocol            = var.health_check_protocol
    health_check_matcher             = var.health_check_matcher
  }
}

module "tg_green" {
  source = "../../modules/LB/target_group"

  name        = "tg-${var.service}-green"
  tags        = var.tags
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check_defaults = {
    health_check_interval            = var.health_check_interval
    health_check_path                = var.health_check_path
    health_check_port                = var.health_check_port
    health_check_healthy_threshold   = var.health_check_healthy_threshold
    health_check_unhealthy_threshold = var.health_check_unhealthy_threshold
    health_check_timeout             = var.health_check_timeout
    health_check_protocol            = var.health_check_protocol
    health_check_matcher             = var.health_check_matcher
  }
}

module "rule_prod" {
  source = "../../modules/LB/listener-rule"

  listener_arn     = var.listener_prod
  target_group_arn = module.tg_blue.arn
  host_header      = [aws_route53_record.app.name]
}

module "rule_test" {
  source = "../../modules/LB/listener-rule"

  listener_arn     = var.listener_test
  target_group_arn = module.tg_green.arn
  host_header      = [aws_route53_record.app.name]
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.service}"
  retention_in_days = var.log_retention

  tags = merge({ Name = "${var.service}-log-group" }, var.tags)
}






