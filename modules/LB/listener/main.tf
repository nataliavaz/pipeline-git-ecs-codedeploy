resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.alb_arn
  port              = var.port
  protocol          = var.protocol
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.action_type
    target_group_arn = var.target_group_arn
  }

  lifecycle {
    ignore_changes = [default_action[0].target_group_arn]
  }
}