# Publish image in GCP Container Registry

### Requirements

Enable Container Registry API in GCP project

### Publish image in GCP Container Registry

```buildoutcfg

# Build image
cd myapp/
docker build -t myapp .

# Run container
docker run -d --name myapp -p 8888:8888 myapp


# Stop and remove container
docker stop myapp
docker rm myapp

# Tag image to Google Cloud Registry
docker tag myapp gcr.io/GCP_PROJECT_ID/IMAGE_NAME

# Push image to Google Cloud Registry
docker push gcr.io/GCP_PROJECT_ID/IMAGE_NAME


# Delete local image and pull image from gcr.io
docker image rm gcr.io/GCP_PROJECT_ID/IMAGE_NAME
docker image pull gcr.io/GCP_PROJECT_ID/IMAGE_NAME
docker image ls

```