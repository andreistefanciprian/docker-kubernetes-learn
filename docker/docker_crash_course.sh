

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


# Name Docker container
docker run --name <DOCKER NAME> busybox:1.29

# Display information about Docker container in json format
docker inspect <CONTAINER ID>
