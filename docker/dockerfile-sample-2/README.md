```bash
# Build image
docker image build -t custom_nginx .

# Run container with new nginx image
docker container run --rm -p 8888:80 nginx_with_html

# Check custom index page
curl http://localhost:8888

# Change tag and push image to dockerhub
docker image tag nginx_with_html:latest DOCKER_ACCOUNT/my_vers_of_nginx:custom_index
docker push DOCKER_ACCOUNT/my_vers_of_nginx:custom_index
```