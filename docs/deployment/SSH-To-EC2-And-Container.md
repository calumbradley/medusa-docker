# How to SSH to the EC2 Instance and Container

```bash
ssh -i ~/.ssh/<insert_ssh_key_path> ec2-user@<insert_ip_address>
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
