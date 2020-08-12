module "sg_lb_ecs" {
  source = "../modules/SecurityGroups"

  name        = "sg_lb_ecs_${var.environment}"
  description = "Security Group LB"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS Access"
    },
    {
      from_port   = 4443
      to_port     = 4443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Listener Teste"
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