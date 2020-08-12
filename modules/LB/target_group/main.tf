resource "aws_lb_target_group" "target_group" {
  name     = var.name
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  deregistration_delay = 90
  target_type          = var.target_type
  slow_start           = 0

  health_check {
    interval            = var.health_check_defaults["health_check_interval"]
    path                = var.health_check_defaults["health_check_path"]
    port                = var.health_check_defaults["health_check_port"]
    healthy_threshold   = var.health_check_defaults["health_check_healthy_threshold"]
    unhealthy_threshold = var.health_check_defaults["health_check_unhealthy_threshold"]
    timeout             = var.health_check_defaults["health_check_timeout"]
    protocol            = var.health_check_defaults["health_check_protocol"]
    matcher             = var.health_check_defaults["health_check_matcher"]
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = false
  }
  tags = var.tags
}