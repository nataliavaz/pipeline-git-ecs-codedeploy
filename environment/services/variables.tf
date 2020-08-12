variable "region" {}

variable "alb_dns_name" {}
variable "alb_name" {}
variable "alb_zone_id" {}

variable "bucket_codepipeline" {
  type        = string
  description = "Bucket de armazenamento dos artefatos do CodePipeline"
}

variable "bucket_codebuild" {
  type        = string
  description = "Bucket de armazenamento de cache do CodeBuild"
}


variable "buildspec" {}
variable "codecommit_arn" {}
variable "codecommit_name" {}
variable "ecs_cluster_name" {}
variable "ecs_cluster_id" {}
variable "ecr_arn" {}
variable "ecr_name" {}
variable "ecr_uri" {}


variable "listener_prod" {}
variable "listener_test" {}

variable "log_retention" {
  default = 180
}
variable "policy_task" {}

variable "sg_lb_id" {}
variable "subnets" {}
variable "vpc_id" {}
variable "zone_id" {}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

//ECS-Fargate
variable "service" {}
variable "app_port" {}
variable "desired_count_app" {}
variable "git_token" {}
variable "git_repos" {}
variable "max_tasks_app" {}
variable "task_cpu_app" {}
variable "task_mem_app" {}
variable "url_service" {}


// Health Check
variable "health_check_interval" {
  default = 10
}
variable "health_check_path" {
  default = "/"
}
variable "health_check_port" {
  default = "traffic-port"
}
variable "health_check_healthy_threshold" {
  default = 5
}
variable "health_check_unhealthy_threshold" {
  default = 5
}
variable "health_check_timeout" {
  default = 5
}
variable "health_check_protocol" {
  default = "HTTP"
}
variable "health_check_matcher" {
  default = "200"
}

//Codedeploy
variable "action_on_timeout" {}
variable "wait_time_in_minutes" {}
variable "action_on_deployment_success" {}
variable "termination_wait_time_in_minutes" {}
variable "deployment_config_name" {}