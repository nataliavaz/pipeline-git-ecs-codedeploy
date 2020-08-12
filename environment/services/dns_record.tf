
resource "aws_route53_record" "app" {
  zone_id = var.zone_id
  name    = var.url_service
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }

  lifecycle {
    prevent_destroy = false
  }
}