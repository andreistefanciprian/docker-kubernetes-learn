
### Build and authenticate GKE cluster

```buildoutcfg

# Create standard 3 None GKE Cluster
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

# Use CloudShell to authenticate kubectl with GKE
gcloud container clusters get-credentials standard-cluster-1 --zone=europe-west2-c

```

### Build redis master and slave and frontend deployments and services

```buildoutcfg
kubectl apply -f redis-master-deployment.yaml
kubectl apply -f redis-master-service.yaml

# Build redis slave deployment and service
kubectl apply -f redis-slave-deployment.yaml
kubectl apply -f redis-slave-service.yaml

# Build frontend deployment and service
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
```

### Monitoring

```buildoutcfg

kubectl get services
kubectl get pods

```

### Cleanup

```buildoutcfg

kubectl delete deployment redis-master redis-slave frontend
kubectl delete service redis-master redis-slave frontend

```


