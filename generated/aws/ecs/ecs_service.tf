resource "aws_ecs_service" "tfer--medusa-app-cluster_medusa-server-task-service-jtm0n8c1" {
  availability_zone_rebalancing = "DISABLED"
  cluster                       = "medusa-app-cluster"

  deployment_circuit_breaker {
    enable   = "true"
    rollback = "true"
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "100"
  desired_count                      = "1"
  enable_ecs_managed_tags            = "true"
  enable_execute_command             = "false"
  health_check_grace_period_seconds  = "0"
  launch_type                        = "EC2"
  name                               = "medusa-server-task-service-jtm0n8c1"

  network_configuration {
    assign_public_ip = "false"
    security_groups  = ["sg-0132e2654f408b77f"]
    subnets          = ["subnet-0217ddd06792e373f", "subnet-0323e2630d7fba5cc", "subnet-08155709ba4611d6a"]
  }

  scheduling_strategy = "REPLICA"
  task_definition     = "arn:aws:ecs:eu-west-2:827854676875:task-definition/medusa-server-task:3"
}
