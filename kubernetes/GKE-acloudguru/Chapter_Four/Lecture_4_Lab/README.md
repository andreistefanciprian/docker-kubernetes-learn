# Ingress Controller Lab


# Lab Objectives

### Create Standard 3-node GKE Cluster
```buildoutcfg
gcloud beta container --project "google-project-name-here" \
clusters create "standard-cluster-1" \
--zone "europe-west2-c" \
--no-enable-basic-auth \
--cluster-version "1.13.10-gke.0" \
--machine-type "n1-standard-1" \
--image-type "COS" --disk-type "pd-standard" --disk-size "100" \
--num-nodes "3" \
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

### Initialize Tiller
```buildoutcfg
# Make Tiller service account a cluster administrator
kubectl apply -f tiller-serviceaccount.yaml

# Initialize Tiller
helm init --service-account helm

# Check if tiller is setup
kubectl get deployment tiller-deploy -n kube-system
```


### Install Ingress Controller with Helm
```buildoutcfg
helm install --name nginx-ingress stable/nginx-ingress

# Check if Ingress Controller was installed
helm list
helm status nginx-ingress

```

### Configure Ingress Resources
```buildoutcfg

kubectl apply -f myapp-blue.yaml
kubectl apply -f myapp-green.yaml
kubectl apply -f myapp-service.yaml

kubectl apply -f ingress-blue.yaml
kubectl apply -f ingress-green.yaml

kubectl get ingresskubectl describe ingress INGRESS_OBJECT

# Test ingress service
# curl --resolve myapp.example.com:80:PUB_IP http://myapp.example.com/green
# curl --resolve myapp.example.com:80:PUB_IP http://myapp.example.com/blue
curl http://gcp.devopsapptest.co.uk/blue
curl http://gcp.devopsapptest.co.uk/green

```

# Cleanup
```buildoutcfg
# Delete GKE Cluster
gcloud beta container clusters delete standard-cluster-1 -q
```