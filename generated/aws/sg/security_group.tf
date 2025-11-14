resource "aws_security_group" "tfer--Amazon-0020-ECS-Optimized-0020-Amazon-0020-Linux-0020-2023-0020--0028-AL2023-0029--0020-x86_64-0020-AMI-2023-002E-0-002E-20251108-AutogenByAWSMP--1_sg-0c4b719e170be03cf" {
  description = "Amazon ECS-Optimized Amazon Linux 2023 (AL2023) x86_64 AMI-2023.0.20251108-AutogenByAWSMP--1 created 2025-11-14T15:19:12.975Z"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "medusa-port-9000"
    from_port   = "9000"
    protocol    = "tcp"
    self        = "false"
    to_port     = "9000"
  }

  ingress {
    cidr_blocks = ["2.218.158.124/32"]
    from_port   = "22"
    protocol    = "tcp"
    self        = "false"
    to_port     = "22"
  }

  name   = "Amazon ECS-Optimized Amazon Linux 2023 (AL2023) x86_64 AMI-2023.0.20251108-AutogenByAWSMP--1"
  vpc_id = "vpc-086fb4e189e19fed5"
}

resource "aws_security_group" "tfer--default_sg-0132e2654f408b77f" {
  description = "default VPC security group"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    from_port = "0"
    protocol  = "-1"
    self      = "true"
    to_port   = "0"
  }

  name   = "default"
  vpc_id = "vpc-086fb4e189e19fed5"
}
