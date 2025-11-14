output "aws_ecs_cluster_tfer--medusa-app-cluster_id" {
  value = "${aws_ecs_cluster.tfer--medusa-app-cluster.id}"
}

output "aws_ecs_service_tfer--medusa-app-cluster_medusa-server-task-service-jtm0n8c1_id" {
  value = "${aws_ecs_service.tfer--medusa-app-cluster_medusa-server-task-service-jtm0n8c1.id}"
}

output "aws_ecs_task_definition_tfer--task-definition-002F-medusa-server-task_id" {
  value = "${aws_ecs_task_definition.tfer--task-definition-002F-medusa-server-task.id}"
}
