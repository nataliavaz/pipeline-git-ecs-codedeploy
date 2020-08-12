variable "application" {
}

variable "policy" {
}

variable "log_retention" {
  default = 180
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "git_token" {}


variable "cache_bucket" {}

variable "compute_type" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "image" {
  default = "aws/codebuild/standard:4.0"
}

variable "git_repos" {}

variable "buildspec" {}

variable "filter_rule" {
  default = ""
}

variable "create_webhook" {
  default = false
}