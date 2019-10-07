```
# Check if swarm is enabled
docker info

# Create docker swarm node/Initialize swarm
docker swarm init

# List docker nodes
docker node ls

# NOTE: docker service replaces docker run
# Create docker service
docker service create alpine ping 8.8.8.8

# List docker services
docker service ls

# List service tasks and history
docker service ps SERVICE_ID/SERVICE_NAME

# Spin up 3 replicas for the same service
docker service update SERVICE_ID/SERVICE_NAME --replicas 3

# Remove docker service
docker service rm SERVICE_ID/SERVICE_NAME
```