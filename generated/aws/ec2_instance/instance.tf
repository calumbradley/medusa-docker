resource "aws_instance" "tfer--i-07c3e762d7e8622cf_medusa-ecs-instance" {
  ami                         = "ami-0f9ab9c43d4871a18"
  associate_public_ip_address = "true"
  availability_zone           = "eu-west-2a"

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_core_count = "1"

  cpu_options {
    core_count       = "1"
    threads_per_core = "2"
  }

  cpu_threads_per_core = "2"

  credit_specification {
    cpu_credits = "unlimited"
  }

  disable_api_stop        = "false"
  disable_api_termination = "false"
  ebs_optimized           = "true"

  enclave_options {
    enabled = "false"
  }

  get_password_data                    = "false"
  hibernation                          = "false"
  iam_instance_profile                 = "ecsInstanceRole"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.micro"
  ipv6_address_count                   = "0"
  key_name                             = "aws-medusa-ssh-keypair"

  maintenance_options {
    auto_recovery = "default"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = "2"
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }

  monitoring                 = "false"
  placement_partition_number = "0"

  private_dns_name_options {
    enable_resource_name_dns_a_record    = "true"
    enable_resource_name_dns_aaaa_record = "false"
    hostname_type                        = "ip-name"
  }

  private_ip = "172.31.16.56"

  root_block_device {
    delete_on_termination = "true"
    encrypted             = "false"
    iops                  = "3000"
    throughput            = "125"
    volume_size           = "30"
    volume_type           = "gp3"
  }

  security_groups   = ["Amazon ECS-Optimized Amazon Linux 2023 (AL2023) x86_64 AMI-2023.0.20251108-AutogenByAWSMP--1"]
  source_dest_check = "true"
  subnet_id         = "subnet-0323e2630d7fba5cc"

  tags = {
    Name = "medusa-ecs-instance"
  }

  tags_all = {
    Name = "medusa-ecs-instance"
  }

  tenancy                = "default"
  user_data_base64       = "IyEvYmluL2Jhc2gKZWNobyBFQ1NfQ0xVU1RFUj1tZWR1c2EtYXBwLWNsdXN0ZXIgPj4gL2V0Yy9lY3MvZWNzLmNvbmZpZw=="
  vpc_security_group_ids = ["sg-0c4b719e170be03cf"]
}
