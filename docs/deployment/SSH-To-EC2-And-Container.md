# How to SSH to the EC2 Instance and Container

```bash
ssh -i ~/.ssh/aws-medusa-ssh-keypair/aws-medusa-ssh-keypair.pem ec2-user@35.177.145.139
```

# List containers

```bash
docker ps -a
```

# View logs

```bash
docker logs CONTAINER_ID
```

# Check ECS errors

```bash
sudo cat /var/log/ecs/ecs-agent.log | grep -i error | tail -20
```

# Exit SSH

```bash
exit
```
