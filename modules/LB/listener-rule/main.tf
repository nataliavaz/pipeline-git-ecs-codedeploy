resource "aws_lb_listener_rule" "rule" {
  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    host_header {
      values = var.host_header
    }
  }

  lifecycle {
    ignore_changes = [action[0].target_group_arn]
  }

}