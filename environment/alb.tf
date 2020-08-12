resource "aws_lb" "alb" {
  name            = "lb-${var.environment}"
  security_groups = module.sg_lb_ecs.id
  subnets         = ["${data.terraform_remote_state.vpc.outputs.public_subnets[0]}", "${data.terraform_remote_state.vpc.outputs.public_subnets[1]}", "${data.terraform_remote_state.vpc.outputs.public_subnets[2]}"]


  enable_deletion_protection = true
  tags = merge(
    local.tags,
    {
      Name        = "lb-${var.application}-${var.environment}"
      Project     = var.application
      Environment = var.environment
    },
  )
}

module "listener_443" {
  source = "../modules/LB/listener"

  alb_arn          = aws_lb.alb.arn
  port             = 443
  protocol         = "HTTPS"
  certificate_arn  = data.aws_acm_certificate.acm.arn
  action_type      = "forward"
  target_group_arn = module.service.tg_blue_arn
}

module "listener_4443" {
  source = "../modules/LB/listener"

  alb_arn          = aws_lb.alb.arn
  port             = 4443
  protocol         = "HTTPS"
  certificate_arn  = data.aws_acm_certificate.acm.arn
  action_type      = "forward"
  target_group_arn = module.service.tg_green_arn
}
