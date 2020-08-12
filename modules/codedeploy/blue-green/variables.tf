
variable "app_name" {
  type        = string
  description = "Aplicação configurada no ambiente"
}

variable "application" {
  type = string
}

variable "action_on_timeout" {
  description = "CONTINUE_DEPLOYMENT, STOP_DEPLOYMENT"
  type        = string
}

variable "action_on_deployment_success" {
  type = string
}

variable "deployment_config_name" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

# variable "environment" {
#   type = string
# }

variable "listener_prod" {
  type = string
}

variable "listener_test" {
  type    = string
  default = ""
}

# variable "service_role_arn" {
#   type        = string
#   description = "ARN da role que define permissões para o GroupDeployment"
# }

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "termination_wait_time_in_minutes" {
  type = number
}

variable "tg_blue" {
  type = string
}

variable "tg_green" {
  type = string
}

variable "traffic_control" {
  type        = string
  description = "Define se havera ou nao controle de trafego no deploy"
  default     = "WITHOUT_TRAFFIC_CONTROL"
}

variable "wait_time_in_minutes" {
  type = number
}


