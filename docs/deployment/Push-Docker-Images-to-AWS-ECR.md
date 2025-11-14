# Push Docker Images to AWS ECR (Elastic Container Registry)

This guide shows how to tag and push your Medusa Docker images to AWS Elastic Container Registry.

## Prerequisites

- Docker image built locally (e.g., `medusa-app:server`)
- AWS CLI configured with appropriate credentials
- ECR repository created in AWS

## Build Docker Image for AMD64 (x86_64)

Build the image for the correct architecture to run on AWS EC2 instances:

```bash
# Build for AMD64 architecture (required for EC2 x86_64 instances)
docker buildx build --platform linux/amd64 -t medusa-app:server .
```

## Authenticate with ECR

First, authenticate Docker to your ECR registry:

```bash
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 827854676875.dkr.ecr.eu-west-2.amazonaws.com
```

**What this does:**

- Gets a temporary password from AWS ECR
- Logs Docker into your ECR registry
- Valid for 12 hours

## Tag the Docker Image

Tag your local image with the ECR repository URL:

```bash
docker tag medusa-app:server 827854676875.dkr.ecr.eu-west-2.amazonaws.com/medusa-app:server
```

**What this does:**

- Tags your local `medusa-app:server` image
- Prepares it for pushing to ECR
- Format: `{account-id}.dkr.ecr.{region}.amazonaws.com/{repository}:{tag}`

## Push to ECR

Push the tagged image to your ECR repository:

```bash
docker push 827854676875.dkr.ecr.eu-west-2.amazonaws.com/medusa-app:server
```

**What this does:**

- Uploads the Docker image to AWS ECR
- Makes it available for deployment on AWS services (ECS, EKS, etc.)

## Complete Workflow

Here's the full sequence of commands:

```bash
# 1. Authenticate
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 827854676875.dkr.ecr.eu-west-2.amazonaws.com

# 2. Tag
docker tag medusa-app:server 827854676875.dkr.ecr.eu-west-2.amazonaws.com/medusa-app:server

# 3. Push
docker push 827854676875.dkr.ecr.eu-west-2.amazonaws.com/medusa-app:server
```

## Notes

- **Region:** `eu-west-2` (London) - change if using a different region
- **Account ID:** `827854676875` - your AWS account ID
- **Repository:** `medusa-app` - must exist in ECR before pushing
- **Tag:** `server` - distinguishes server vs worker images
