variable "name" {
  type = string
}

variable "health_check_defaults" {
  description = "Default values for target groups as defined by the list of maps."
  type = object(
    {
      health_check_interval            = number,
      health_check_healthy_threshold   = string,
      health_check_path                = string,
      health_check_port                = string,
      health_check_timeout             = string,
      health_check_unhealthy_threshold = string,
      health_check_matcher             = string,
      health_check_protocol            = string,
    }
  )
  default = {
    health_check_interval            = 30
    health_check_healthy_threshold   = 5
    health_check_path                = "/"
    health_check_port                = "traffic-port"
    health_check_timeout             = 25
    health_check_unhealthy_threshold = 3
    health_check_matcher             = "200-299"
    health_check_protocol            = "HTTP"
  }
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "target_type" {
  type = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}