
# Deployment Patterns

Rolling Updates (default)

Canary Deployment

Blue Green Deployments


# Lab Objectives

### Create Standard 3-node GKE Cluster
```buildoutcfg
gcloud beta container --project "aerial-utility-246511" \
clusters create "standard-cluster-1" \
--zone "europe-west2-c" \
--no-enable-basic-auth \
--cluster-version "1.13.10-gke.0" \
--machine-type "n1-standard-1" \
--image-type "COS" --disk-type "pd-standard" --disk-size "100" \
--num-nodes "3" \
--enable-cloud-logging --enable-cloud-monitoring \
--enable-ip-alias \
--network "projects/aerial-utility-246511/global/networks/default" \
--subnetwork "projects/aerial-utility-246511/regions/europe-west2/subnetworks/default" \
--addons HorizontalPodAutoscaling,HttpLoadBalancing \
--enable-autoupgrade --enable-autorepair
```

### Authenticate kubectl with gcloud
```buildoutcfg
gcloud container clusters get-credentials standard-cluster-1 --zone=europe-west2-c
```

### Create blue/green images of myapp
```buildoutcfg
# Create myapp:v1 docker image and push it to GCR
gcloud builds submit --tag gcr.io/aerial-utility-246511/myapp:v1
#or
docker build -t myapp .
docker tag myapp gcr.io/aerial-utility-246511/myapp:v1 && docker push gcr.io/aerial-utility-246511/myapp:v1

# Create myapp:v3 docker image and push it to GCR
docker build -t myapp .
docker tag myapp gcr.io/aerial-utility-246511/myapp:v2 && docker push gcr.io/aerial-utility-246511/myapp:v2

# Create myapp:v3 docker image and push it to GCR
docker build -t myapp .
docker tag myapp gcr.io/aerial-utility-246511/myapp:v3 && docker push gcr.io/aerial-utility-246511/myapp:v3

```

### Create blue deployment of myapp
```buildoutcfg
# Create myapp-blue deployment
kubectl apply -f myapp-blue.yaml

# Direct traffic to blue deployment
kubectl apply -f myapp-service.yaml
```

### Update application versions and switch traffic
```buildoutcfg
# Create myapp-green deployment
kubectl apply -f myapp-green.yaml

# When happy to switch over, edit the service yaml by changing the selector to version: green
# Direct traffic to green deployment
kubectl apply -f myapp-service.yaml

# Verify service is directing traffic to green pods
kubectl describe service myapp-service


# Update image to myapp:v3 in blue deployment and direct traffic to blue pods
kubectl apply -f myapp-blue.yaml
# Change selector to version: blue
kubectl apply -f myapp-service.yaml

# Since myapp:v3 has an issue, shitch traffic back to green pods that are running myapp:v2 containers
# Change selector to version: green
kubectl apply -f myapp-service.yaml


```

### Create a canary deployment
```buildoutcfg
# Remove current deployments
kubectl delete -f myapp-blue.yaml
kubectl delete -f myapp-green.yaml

# Apply deployments and new service
kubectl apply -f myapp-prod.yaml
kubectl apply -f myapp-canary.yaml
kubectl apply -f myapp-service.yaml

# Verify if canary image myapp:v3 gets displayed when accesing the website
while true; do curl http://LoadBalancerGlobalIPAddress/ ; sleep 0.5; done

```

# Cleanup
```buildoutcfg
GKE-acloudgurugcloud beta container clusters delete standard-cluster-1 -q
```
