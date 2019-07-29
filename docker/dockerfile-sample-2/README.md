```buildoutcfg
# Build image
docker image build -t custom_nginx .

# Run container with new nginx image
docker container run --rm -p 8888:80 custom_nginx

# Access docker app
curl http://localhost:8888

# Change tag and push image to docker hub
docker image tag custom_nginx:latest YOUR_USERNAME/my_vers_of_nginx:custom_index
docker push YOUR_USERNAME/my_vers_of_nginx:custom_index
```