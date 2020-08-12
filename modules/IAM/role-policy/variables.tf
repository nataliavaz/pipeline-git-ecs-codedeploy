variable "name" {
  type = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "policy" {
  type = string
}

variable "service" {
  type = string
}


