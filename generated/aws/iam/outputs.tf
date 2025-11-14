output "aws_iam_instance_profile_tfer--ecsInstanceRole_id" {
  value = "${aws_iam_instance_profile.tfer--ecsInstanceRole.id}"
}

output "aws_iam_role_policy_attachment_tfer--AWSServiceRoleForECSCompute_AmazonECSComputeServiceRolePolicy_id" {
  value = "${aws_iam_role_policy_attachment.tfer--AWSServiceRoleForECSCompute_AmazonECSComputeServiceRolePolicy.id}"
}

output "aws_iam_role_policy_attachment_tfer--AWSServiceRoleForECS_AmazonECSServiceRolePolicy_id" {
  value = "${aws_iam_role_policy_attachment.tfer--AWSServiceRoleForECS_AmazonECSServiceRolePolicy.id}"
}

output "aws_iam_role_policy_attachment_tfer--AWSServiceRoleForResourceExplorer_AWSResourceExplorerServiceRolePolicy_id" {
  value = "${aws_iam_role_policy_attachment.tfer--AWSServiceRoleForResourceExplorer_AWSResourceExplorerServiceRolePolicy.id}"
}

output "aws_iam_role_policy_attachment_tfer--AWSServiceRoleForSupport_AWSSupportServiceRolePolicy_id" {
  value = "${aws_iam_role_policy_attachment.tfer--AWSServiceRoleForSupport_AWSSupportServiceRolePolicy.id}"
}

output "aws_iam_role_policy_attachment_tfer--AWSServiceRoleForTrustedAdvisor_AWSTrustedAdvisorServiceRolePolicy_id" {
  value = "${aws_iam_role_policy_attachment.tfer--AWSServiceRoleForTrustedAdvisor_AWSTrustedAdvisorServiceRolePolicy.id}"
}

output "aws_iam_role_policy_attachment_tfer--ecsInfrastructureRoleForManagedInstances_AmazonECSInfrastructureRolePolicyForManagedInstances_id" {
  value = "${aws_iam_role_policy_attachment.tfer--ecsInfrastructureRoleForManagedInstances_AmazonECSInfrastructureRolePolicyForManagedInstances.id}"
}

output "aws_iam_role_policy_attachment_tfer--ecsInstanceRole_AmazonECSInstanceRolePolicyForManagedInstances_id" {
  value = "${aws_iam_role_policy_attachment.tfer--ecsInstanceRole_AmazonECSInstanceRolePolicyForManagedInstances.id}"
}

output "aws_iam_role_policy_attachment_tfer--ecsTaskExecutionRole_AmazonECSTaskExecutionRolePolicy_id" {
  value = "${aws_iam_role_policy_attachment.tfer--ecsTaskExecutionRole_AmazonECSTaskExecutionRolePolicy.id}"
}

output "aws_iam_role_tfer--AWSServiceRoleForECSCompute_id" {
  value = "${aws_iam_role.tfer--AWSServiceRoleForECSCompute.id}"
}

output "aws_iam_role_tfer--AWSServiceRoleForECS_id" {
  value = "${aws_iam_role.tfer--AWSServiceRoleForECS.id}"
}

output "aws_iam_role_tfer--AWSServiceRoleForResourceExplorer_id" {
  value = "${aws_iam_role.tfer--AWSServiceRoleForResourceExplorer.id}"
}

output "aws_iam_role_tfer--AWSServiceRoleForSupport_id" {
  value = "${aws_iam_role.tfer--AWSServiceRoleForSupport.id}"
}

output "aws_iam_role_tfer--AWSServiceRoleForTrustedAdvisor_id" {
  value = "${aws_iam_role.tfer--AWSServiceRoleForTrustedAdvisor.id}"
}

output "aws_iam_role_tfer--ecsInfrastructureRoleForManagedInstances_id" {
  value = "${aws_iam_role.tfer--ecsInfrastructureRoleForManagedInstances.id}"
}

output "aws_iam_role_tfer--ecsInstanceRole_id" {
  value = "${aws_iam_role.tfer--ecsInstanceRole.id}"
}

output "aws_iam_role_tfer--ecsTaskExecutionRole_id" {
  value = "${aws_iam_role.tfer--ecsTaskExecutionRole.id}"
}
