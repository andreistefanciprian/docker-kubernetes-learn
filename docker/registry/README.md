# Docker Registry

```buildoutcfg

# Build local/private docker registry
docker pull registry
docker container run -d -p 5000:5000 --name registry registry

# Check if registry container is running on port 5000
docker container ls

# Retag existing nginx image to use local registry 127.0.0.1:5000
docker pull nginx
docker container run -p 8080:80 nginx
docker tag nginx 127.0.0.1:5000/nginx

# Check if nginx image has been tagged
docker image ls

# Push image to local registry
docker push 127.0.0.1:5000/nginx

# Remove nginx container and images
docker container rm -f nginx
docker image rm nginx
docker image rm 127.0.0.1:5000/nginx

# Pull image from local registry
docker pull 127.0.0.1:5000/nginx

# Run container using 127.0.0.1:5000/nginx image
docker container run -p 8080:80 127.0.0.1:5000/nginx


```

# Remove local registry and rebuild it with local volume

```buildoutcfg

# Remove registry
docker container kill registry
docker container rm registry

# Build new registry, push image and check if it was stored locally
docker container run -d -p 5000:5000 --name registry -v $(pwd)/registry-data:/var/lib/registry registry
docker pull 127.0.0.1:5000/nginx
tree

```

# Clean up
```buildoutcfg
docker container stop `docker container ls -aq`
docker container rm `docker container ls -aq`
docker image rm `docker image ls -aq`
docker volume rm `docker volume ls -q`

```

# Docker registry for linux with certificate and authentication
```html
https://training.play-with-docker.com/linux-registry-part2/
```

# Docker registry in swarm

```bash
# Create local registry service
docker service create --name registry --publish 5000:5000 registry

docker image pull nginx
docker tag nginx 127.0.0.1:5000/nginx
docker image push 127.0.0.1:5000/nginx

# Create docker service using image from registry
docker service create --name nginx --publish 8080:80 --replicas 5  --detach=false 127.0.0.1:5000/nginx

```