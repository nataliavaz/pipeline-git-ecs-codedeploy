variable "region" {}

variable "application" {}

variable "app_port" {}
variable "bucket_remote_state" {
  type        = string
  description = "Bucket de armazenamento do state do terraform"
}

variable "bucket_codepipeline" {
  type        = string
  description = "Bucket de armazenamento dos artefatos do CodePipeline"
}

variable "bucket_codebuild" {
  type        = string
  description = "Bucket de armazenamento de cache do CodeBuild"
}

variable "domain" {}

variable "environment" {}

variable "frontend_url" {}

variable "git_repos" {}
variable "git_token" {}
variable "git_cf_repos" {}
variable "git_cf_token" {}
variable "log_retention" {
  default = 180
}

variable "service" {}
variable "url_service" {}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

