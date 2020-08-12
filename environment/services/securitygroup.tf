module "sg_ecs_app" {
  source = "../../modules/SecurityGroups"

  name        = "sg_ecs_${replace(var.service, "-", "_")}"
  description = "Security Goup ECS Task ${var.service}"
  vpc_id      = var.vpc_id

  ingress_rules = [
    {
      from_port       = var.app_port
      to_port         = var.app_port
      protocol        = "tcp"
      security_groups = var.sg_lb_id
      description     = var.alb_name
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}