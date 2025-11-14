resource "aws_ecs_task_definition" "tfer--task-definition-002F-medusa-server-task" {
  container_definitions    = "[{\"environment\":[],\"environmentFiles\":[],\"essential\":true,\"image\":\"827854676875.dkr.ecr.eu-west-2.amazonaws.com/medusa-app@sha256:7d9fa00a652838dd996736ceaa2704f535adb31f5023d310c3725cea33a3cedc\",\"logConfiguration\":{\"logDriver\":\"awslogs\",\"options\":{\"awslogs-create-group\":\"true\",\"awslogs-region\":\"eu-west-2\",\"awslogs-stream-prefix\":\"ecs\",\"awslogs-group\":\"/ecs/medusa-server-task\"},\"secretOptions\":[]},\"mountPoints\":[],\"name\":\"medusa-server\",\"portMappings\":[{\"appProtocol\":\"http\",\"containerPort\":9000,\"hostPort\":9000,\"name\":\"medusa-server-9000-tcp\",\"protocol\":\"tcp\"}],\"systemControls\":[],\"ulimits\":[],\"volumesFrom\":[]}]"
  cpu                      = "1024"
  enable_fault_injection   = "false"
  execution_role_arn       = "arn:aws:iam::827854676875:role/ecsTaskExecutionRole"
  family                   = "medusa-server-task"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["MANAGED_INSTANCES"]

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  track_latest = "false"
}
