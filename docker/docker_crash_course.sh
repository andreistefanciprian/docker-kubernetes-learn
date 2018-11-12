

# use Docker as a non-root user. Log out and back in for this to take effect!
sudo usermod -aG docker $(whoami)

# List docker local images
docker images

# Run busybox image
docker run -it --rm busybox:1.29

# Run docker container in dettached mode
sudo docker run -itd busybox:1.29 sleep 100

# List docker running containers
sudo docker ps

# List docker running containers plus previously run containers
sudo docker ps -a

# Connect to running Docker container
docker exec -ti <CONTAINER ID> bash

# Stop/Remove Docker containers
docker stop <CONTAINER ID>
docker rm <CONTAINER ID>

# Name Docker container
docker run --name <DOCKER NAME> busybox:1.29

# Display information about Docker container in json format
docker inspect <CONTAINER ID>

# Run Docker Tomcat webserver on docker port 8080 and localhost port 8888
docker run -it --rm -d -p 8888:8080 tomcat:alpine

# See container logs
docker logs <CONTAINER ID>

# See how many layers a docker images has
docker history busybox:1.29

## Build docker image
docker commit <CONTAINER ID> repository_name TAG
docker commit 1f227c300d20 andreistefanciprian/busybox:test1
docker run -it andreistefanciprian/busybox:test1

# Docker files - used for building the image
docker build -t andreistefanciprian/ubuntu:tag .

# Push Docker image to dockerhub
docker tag <CONTAINER ID> andreistefanciprian/ubuntu:1.01
docker login --username=andreistefanciprian
docker push andreistefanciprian/ubuntu:1.01


