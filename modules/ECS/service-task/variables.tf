variable "application" {
  type = string
}

variable "app_image" {
  type = string
}

variable "app_port" {
  type    = number
  default = 80
}

variable "cluster_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "container_protocol" {
  type = string
}

variable "desired_count" {
  type = number
}

# variable "ecs_autoscale_role" {
#   type = string
# }

# variable "fargate_cpu" {
#   type = number
# }

# variable "fargate_memory" {
#   type = number
# }

variable "launch_type" {
  default = ["FARGATE"]
}

variable "load_balancer_conf" {
  default = [
    {
      target_group_arn = "tg_arn"
      container_name   = "container_name"
      container_port   = "container_port"
    }
  ]
}

variable "max_tasks" {
  type = number
}

variable "platform_version" {
  default = "LATEST"
}

variable "policy_task_execution" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "security_groups" {
  type = list
}

variable "subnets" {
  type = list
}

variable "task_cpu" {
  type = number
}

variable "task_mem" {
  type = number
}

# variable "tg_blue" {
#   type = string
# }

# variable "tg_blue_arn" {
#   type = string
# }

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}


