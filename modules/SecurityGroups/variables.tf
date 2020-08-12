# variable "aplicacao" {
#   type        = string
#   description = "Aplicação configurada no ambiente"
#   default     = "app"
# }

variable "description" {
  type        = string
  description = "Descrição do Security Group"
  default     = "Security Group"
}

variable "enable" {
  type    = bool
  default = true
}

variable "egress_rules" {
  description = "Regras de saída adicionais no Security Group"
  //type        = list(map(string))
  default = [
    {
      description = ""
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "ingress_rules" {
  description = "Regras de entrada adicionais no Security Group"
  //type        = list(map(string))
  default = [
    # {
    #   description     = ""
    #   from_port       = 80
    #   to_port         = 80
    #   protocol        = "HTTP"
    #   cidr_blocks     = []
    #   security_groups = []
    # }
  ]
}

variable "name" {
  type        = string
  description = "Nome do Security Group"
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "ID do VPC no qual o target Group será criado"
  default     = "vpc-abcde012"
}