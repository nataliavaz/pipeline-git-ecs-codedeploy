# variable "aplicacao" {
#   type = string
# }

variable "name" {
  type = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}


variable "policy_arn" {
  type = string
}

variable "service" {
  type = string
}


