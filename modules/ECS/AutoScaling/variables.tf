variable "aplicacao" {
  type = string
}

variable "cluster_name" {
  description = "The cluster_name"
}

variable "service_name" {
  description = "The service_name"
}

variable "min_tasks" {
  description = "Minimum"
}

variable "max_tasks" {
  description = "Maximum"
}

variable "cpu_to_scale_up" {
  description = "CPU % to Scale Up the number of containers"
}

variable "cpu_to_scale_down" {
  description = "CPU % to Scale Down the number of containers"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# variable "ecs_autoscale_role" {
#   type = string
# }
