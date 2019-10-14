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

# Build GCE from docker image

```buildoutcfg

gcloud beta compute --project=$PROJECT instances \
create-with-container INSTANCE_NAME \
--machine-type=f1-micro \
--subnet=default \
--metadata=google-logging-enabled=true \
--tags=container,http-server,https-server \
--image=cos-stable-77-12371-89-0 --image-project=cos-cloud \
--container-image=gcr.io/aerial-utility-246511/myapp:latest 
--container-restart-policy=always 
--reservation-affinity=any

gcloud compute --project=$PROJECT \
firewall-rules create allow-ingress-container \
--direction=INGRESS \
--priority=1000 \
--network=default \
--action=ALLOW \
--rules=tcp:8888 \
--source-ranges=0.0.0.0/0 \
--target-tags=container


```

# Build GKE cluster

Google Kubernetes Engine API have to be enabled.

```buildoutcfg

# Build GKE cluster
gcloud beta container \
--project $PROJECT \
clusters create "your-first-cluster-1" \
--zone "europe-west2-c" \
--no-enable-basic-auth \
--cluster-version "1.14.6-gke.13" \
--machine-type "g1-small" \
--image-type "COS" \
--disk-type "pd-standard" \
--disk-size "30" \
--num-nodes "1" \
--no-enable-cloud-logging \
--no-enable-cloud-monitoring \
--enable-ip-alias \
--network "projects/${PROJECT}/global/networks/default" \
--subnetwork "projects/${PROJECT}/regions/europe-west2-c/subnetworks/default" \
--default-max-pods-per-node "110" \
--addons HorizontalPodAutoscaling,HttpLoadBalancing \
--enable-autoupgrade \
--enable-autorepair \
--no-shielded-integrity-monitoring

# Go to Container registry, select myapp image and go through the Deploy in GKE wizard to run the image inside the GKE cluster
# Expose port 80:8888


# CloudShel commands

# Authenticate kubectl with GKE
gcloud container clusters get-credentials your-first-cluster-1 --zone=europe-west2-c

kubectl get nodes
kubectl get services


# Create a new pod and expose port 80
kubectl run my-nginx --image nginx
kubectl expose deployment my-nginx --port=80 --type=LadBalancer

```

