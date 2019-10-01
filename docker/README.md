# Help
```buildoutcfg
docker container run --help
```


# Start a container
```buildoutcfg
# Run nginx (alpine image) docker container on 8080 locahost port, 80 docker port
docker container run --publish 8080:80 --detach --name web1 nginx:alpine
# Run container and command inside the container
docker container run --publish 8080:80 --detach --name web1 nginx:alpine nginx -t



```
# Monitoring
```buildoutcfg
# List running containers
docker container ls

# List running and stopped containers
docker container ls -a

# List running processes in container
docker container top CONTAINER_NAME

# Performance stats for all containers
docker container stats

# Display how container was built/run
docker container inspect CONTAINER_NAME

# Display logs continuously
docker container logs -f CONTAINER_NAME
```
# Update running docker container
```
docker update --help
```

# Get a Shell inside container
```buildoutcfg
# Build mysql docker container
docker container run --name=mysql -e MYSQL_RANDOM_ROOT_PASSWORD=yes -p 3306:3306 -d mysql

# Execute commands inside running container
mysql_password=`docker container logs mysql | grep 'GENERATED ROOT PASSWORD' | cut -d' ' -f4`
docker container exec -it mysql mysql -uroot -p$mysql_password
docker container exec -it mysql cat /etc/mysql/my.cnf

docker container exec -it mysql apt update && apt-get install -y curl
docker container exec -it mysql curl -I google.com

# Get shell prompt inside running container
docker container exec -it mysql bash

# Build ubuntu container and get shell prompt access
docker container run -it --name ubuntu bash

# Start container and get shell access
docker container start -ai ubuntu
```


# Networking
```buildoutcfg
# List open ports inside container
docker container port CONTAINER_NAME

# Get IP Address of running container
docker container inspect --format '{{ .NetworkSettings.IPAddress }}' CONTAINER_NAME

# Show networks
docker network ls

# Inspect a network
docker network inspect NETWORK_ID/NETWORK_NAME

# Create a network
docker network create NETWORK_NAME

# Attach/Detach container to/from network
docker network connect NETWORK_ID CONTAINER_ID
docker network disconnect NETWORK_ID CONTAINER_ID

# Build DNS Round Robin (Load Balancer)
docker network create dude
docker container run -d --network dude --net-alias search elasticsearch:2
docker container run -d --network dude --net-alias search elasticsearch:2
# Test DNS round robin
docker container run -rm --network dude alpine nslookup search
# Run this command a few times
docker container run --rm --network dude centos curl -s search:9200
```


# Docker images
```buildoutcfg
# List local docker images
docker image ls
# Download image localy
docker pull nginx:1.17.1
# Display imahe layer history
docker image history REPOSITORY:TAG
# Display docker image metadata
docker image inspect REPOSITORY

# Create a new image and tag it based on current image
# Make sure you're logged in via CLI (docker login)
docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

```


# Dockerfile
```bash
# Build dockerfile in current dir
docker image build -t IMAGE_NAME .

```


# Stop and remove containers
```buildoutcfg

# Stop container
docker container stop CONTAINER_ID

# Remove container
docker container rm CONTAINER_ID1 CONTAINER_ID2 ...

# Remove running container
docker container rm -f CONTAINER_ID1

# Stop and remove all containers
docker container stop $(docker container ps -a -q)
docker container stop $(docker container ps -a -q)

# To clean up, all unused containers, images, network, and volumes, use the following command.
docker system prune
docker system prune -a

# To individually delete all the components, use the following commands.
docker container prune
docker image prune
docker network prune
docker volume prune

# Check docker used space
docker system df

```