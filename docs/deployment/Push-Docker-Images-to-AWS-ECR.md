# Push Docker Images to AWS ECR (Elastic Container Registry)

# Authenticate first (still needed)

```bash
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 827854676875.dkr.ecr.eu-west-2.amazonaws.com
```

# Build, tag, and push in one command

```bash
docker buildx build \
 --platform linux/amd64 \
 --tag 827854676875.dkr.ecr.eu-west-2.amazonaws.com/medusa-app:server \
 --push \
 .
```
