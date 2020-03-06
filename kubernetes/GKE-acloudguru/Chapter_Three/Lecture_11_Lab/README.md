# Auto scaling

HorizontalPodAutoscaler
VerticalPodAutoscaler
ClusterAutoscaler

# Lab Objectives

### Create Standard 3-node GKE Cluster
```buildoutcfg
gcloud beta container --project "google-project-name-here" \
clusters create "standard-cluster-1" \
--zone "europe-west2-c" \
--no-enable-basic-auth \
--cluster-version "1.13.10-gke.0" \
--machine-type "n1-standard-2" \
--image-type "COS" --disk-type "pd-standard" --disk-size "30" \
--num-nodes "1" \
--enable-cloud-logging --enable-cloud-monitoring \
--enable-ip-alias \
--network "projects/google-project-name-here/global/networks/default" \
--subnetwork "projects/google-project-name-here/regions/europe-west2/subnetworks/default" \
--addons HorizontalPodAutoscaling,HttpLoadBalancing \
--enable-autoupgrade --enable-autorepair
```

### Authenticate kubectl with gcloud
```buildoutcfg
gcloud container clusters get-credentials standard-cluster-1 --zone=europe-west2-c
```

### Add a HorizontalPodAustoscaler to myapp
```buildoutcfg

# Build mmyapp deployment
kubectl apply -f myapp-scaling.yaml
kubectl apply -f myapp-service.yaml
kubectl apply -f myapp-hpa.yaml

```

### Simulate high demand and observe autoscaling of pods
```buildoutcfg
# Simulate high demand
go get -u github.com/rakyll/hey
hey -z 2m -c 50 http://LoadBalancerPublicIP/

# Observe autoscaling of pods
kubectl get pods -o wide -w 

```

### Enable GKE Cluster Autoscaling on the nodepool

### Simulate high demand and observe autoscaling of nodes and pods

```buildoutcfg
# Simulate high demand
hey -z 5m http://LoadBalancerPublicIP/

# Observe autoscaling of pods
kubectl get pods -o wide -w 
```

# Cleanup
```buildoutcfg
gcloud beta container clusters delete standard-cluster-1 -q
```