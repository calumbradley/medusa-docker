resource "aws_ecs_cluster" "tfer--medusa-app-cluster" {
  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  name = "medusa-app-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
