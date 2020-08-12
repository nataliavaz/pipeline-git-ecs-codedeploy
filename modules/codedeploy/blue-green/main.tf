resource "aws_codedeploy_deployment_group" "blue_green" {
  app_name               = var.app_name
  deployment_group_name  = var.application
  service_role_arn       = module.IAM_CodedeployECS.arn
  deployment_config_name = var.deployment_config_name

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.ecs_cluster_name
    service_name = var.ecs_service_name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = ["${var.listener_prod}"]
      }
      test_traffic_route {
        listener_arns = ["${var.listener_test}"]
      }
      target_group {
        name = var.tg_blue
      }
      target_group {
        name = var.tg_green
      }
    }
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout    = var.action_on_timeout
      wait_time_in_minutes = var.wait_time_in_minutes
    }

    terminate_blue_instances_on_deployment_success {
      action                           = var.action_on_deployment_success
      termination_wait_time_in_minutes = var.termination_wait_time_in_minutes
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}