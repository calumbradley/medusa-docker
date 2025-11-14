# AWS Infrastructure (Terraform)

Auto-generated Terraform configuration documenting the Medusa ECS deployment on AWS.

## Overview

This infrastructure runs a Medusa e-commerce application on AWS ECS using EC2 instances. It's optimized for the AWS free tier.

## Infrastructure Components

### ECS (`aws/ecs/`)

**Cluster:** `medusa-app-cluster`

- Container Insights: Disabled (cost optimization)
- Deployment strategy: Rolling updates with circuit breaker

**Service:** `medusa-server-task-service-jtm0n8c1`

- Launch type: EC2
- Desired count: 1 task
- Deployment: Circuit breaker enabled with auto-rollback
- Network: awsvpc mode with default VPC

**Task Definition:** `medusa-server-task` (revision 3)

- CPU: 1 vCPU (1024 units)
- Memory: 512 MB
- Architecture: X86_64 (AMD64)
- Container: `medusa-server`
  - Port: 9000 (HTTP)
  - Image: ECR `medusa-app@sha256:7d9fa00a...`
  - Logs: CloudWatch `/ecs/medusa-server-task`

### EC2 Instance (`aws/ec2_instance/`)

**Instance:** `medusa-ecs-instance`

- Type: t3.micro (free tier eligible)
- AMI: Amazon Linux 2023 ECS-Optimized
- Storage: 30 GB gp3 (free tier)
- Public IP: Enabled
- SSH Key: `aws-medusa-ssh-keypair`
- User Data: Configures ECS agent to join cluster

**User Data Script:**

```bash
#!/bin/bash
echo ECS_CLUSTER=medusa-app-cluster >> /etc/ecs/ecs.config
```

````

### Security Groups (`aws/sg/`)

**EC2 Security Group:**

- **Ingress:**
  - Port 9000 (TCP): Open to world (0.0.0.0/0) - Medusa API/Admin
  - Port 22 (SSH): Restricted to your IP (2.218.158.124/32)
- **Egress:** All traffic allowed

**Default VPC Security Group:**

- Used by ECS service networking
- Allows internal VPC communication

### ECR Repository (`aws/ecr/`)

**Repository:** `medusa-app`

- Region: eu-west-2 (London)
- Contains Docker images for Medusa application
- Images built for AMD64 architecture

### IAM Roles (`aws/iam/`)

**ecsTaskExecutionRole:**

- Allows ECS to pull images from ECR
- Allows CloudWatch log creation
- Required for task execution

**ecsInstanceRole:**

- Allows EC2 instances to join ECS cluster
- Enables ECS agent communication

## Architecture

```
Internet
    │
    ├──> EC2 Instance (t3.micro)
    │    ├──> ECS Agent
    │    └──> Docker Container (Medusa)
    │         └──> Port 9000
    │
    └──> Security Group (Port 9000, SSH)
```

## Key Configuration Details

### Memory Allocation

- **Total EC2 Memory:** ~1 GB (t3.micro)
- **Available for containers:** ~904 MB
- **Task allocation:** 512 MB
- **Remaining for system:** ~400 MB

### Networking

- **Network Mode:** awsvpc (task gets own ENI)
- **VPC:** Default VPC (vpc-086fb4e189e19fed5)
- **Subnets:** Multi-AZ deployment across 3 subnets
- **Public Access:** Via EC2 instance public IP on port 9000

### Container Image

- **Source:** AWS ECR (eu-west-2)
- **Architecture:** AMD64 (linux/amd64)
- **Build Command:** `docker buildx build --platform linux/amd64`
- **Critical:** Must be AMD64 for EC2 x86_64 instances

## Cost Optimization

This setup is optimized for AWS free tier:

- ✅ t3.micro EC2 instance (750 hours/month free)
- ✅ 30 GB gp3 storage (30 GB free)
- ✅ CloudWatch Logs (5 GB free)
- ✅ ECR storage (500 MB free)
- ✅ Data transfer (15 GB out free)

**Estimated monthly cost:** $0 (within free tier limits)

## Environment Variables (Not Captured)

The following environment variables need to be configured in the task definition:

```bash
COOKIE_SECRET=<generate-secure-random-string>
JWT_SECRET=<generate-secure-random-string>
DATABASE_URL=<postgres-connection-string>
REDIS_URL=<redis-connection-string>
LOCKING_REDIS_URL=<redis-connection-string>
CACHE_REDIS_URL=<redis-connection-string>
MEDUSA_WORKER_MODE=server
DISABLE_MEDUSA_ADMIN=false
PORT=9000
```

**Note:** These are not exported by Terraformer and must be added separately.

## Deployment Process

### Initial Setup

1. **Build Docker image for AMD64:**

   ```bash
   docker buildx build --platform linux/amd64 -t medusa-app:server .
   ```

2. **Push to ECR:**

   ```bash
   aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 827854676875.dkr.ecr.eu-west-2.amazonaws.com
   docker tag medusa-app:server 827854676875.dkr.ecr.eu-west-2.amazonaws.com/medusa-app:server
   docker push 827854676875.dkr.ecr.eu-west-2.amazonaws.com/medusa-app:server
   ```

3. **Deploy infrastructure with Terraform** (if recreating):
   ```bash
   cd generated/aws
   terraform init
   terraform plan
   terraform apply
   ```

### Updates

To deploy application updates:

1. Build and push new Docker image
2. Update ECS service to force new deployment:
   - AWS Console: Service → Update → Force new deployment
   - AWS CLI: `aws ecs update-service --cluster medusa-app-cluster --service medusa-server-task-service-jtm0n8c1 --force-new-deployment`

## Access & Monitoring

### Application Access

- **Health Check:** `http://<EC2_PUBLIC_IP>:9000/health`
- **Admin Dashboard:** `http://<EC2_PUBLIC_IP>:9000/app`
- **API:** `http://<EC2_PUBLIC_IP>:9000`

### SSH Access

```bash
chmod 400 ~/.ssh/aws-medusa-ssh-keypair/aws-medusa-ssh-keypair.pem
ssh -i ~/.ssh/aws-medusa-ssh-keypair/aws-medusa-ssh-keypair.pem ec2-user@<EC2_PUBLIC_IP>
```

### Logs

- **CloudWatch:** AWS Console → CloudWatch → Log Groups → `/ecs/medusa-server-task`
- **SSH + Docker:** `docker logs <container_id>`
- **ECS Agent:** `sudo tail -f /var/log/ecs/ecs-agent.log`

## Troubleshooting

### Task fails to start: "insufficient memory"

- EC2 instance (904 MB) < Task definition memory requirement
- Solution: Reduce task memory or upgrade to larger instance

### "no matching manifest for linux/amd64"

- Docker image built for wrong architecture (ARM)
- Solution: Rebuild with `--platform linux/amd64` flag

### Container stops immediately

- Missing environment variables (DATABASE_URL, REDIS_URL)
- Check CloudWatch logs for error details

### Cannot SSH to instance

- Key permissions too open: `chmod 400 <key>.pem`
- Security group doesn't allow your IP
- Instance doesn't have public IP

## Generated Files

These Terraform files were auto-generated using Terraformer on 14 November 2025:

```bash
terraformer import aws --resources=ecs --regions=eu-west-2
terraformer import aws --resources=ec2_instance --regions=eu-west-2
terraformer import aws --resources=ecr --regions=eu-west-2
terraformer import aws --resources=iam --regions=eu-west-2
terraformer import aws --resources=sg --regions=eu-west-2
```

**Note:** `.tfstate` files are excluded from git as they may contain sensitive data.

## Next Steps

1. **Add environment variables** to task definition
2. **Configure databases** (PostgreSQL, Redis)
3. **Set up proper secrets management** (AWS Secrets Manager)
4. **Add Application Load Balancer** for production
5. **Configure auto-scaling** based on metrics
6. **Set up CloudWatch alarms** for monitoring
7. **Implement CI/CD pipeline** for automated deployments

## Related Documentation

- Push Docker Images to ECR
- SSH and Check Logs
- General Medusa Deployment Guide
````
