variable "application" {
  type = string
}

variable "artifact_store" {
  type = string
}

variable "codedeploy_app" {
  type = string
}

variable "codeploy_deploymentgroup" {
  type = string
}

variable "repository_codecommit" {
  type = string
}

variable "repository_codecommit_arn" {
  type = string
}

variable "repository_ecr" {
  type = string
}

variable "resource_passrole" {

}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

