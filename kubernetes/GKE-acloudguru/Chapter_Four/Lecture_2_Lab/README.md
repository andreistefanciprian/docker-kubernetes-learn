# HELM

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

### Create Tiller service account and make the service account a cluster administrator
```buildoutcfg
kubectl apply -f tiller-serviceaccount.yaml
```
### Install Helm
```buildoutcfg
wget https://git.io/get_helm.sh
bash get_helm.sh
helm init --service-account helm

# Check if tiller is setup
kubectl get deploy,svc tiller-deploy -n kube-system

```

### Install Bookstack application with Helm
```buildoutcfg
helm install stable/bookstack

# Monitoring
kubectl get pv
kubectl get services
kubectl get deployments
kubectl get statefulset

helm status operatic-numbat

```

### Query, update and remove Helm releases
```buildoutcfg
helm upgrade --set service.type='LoadBalancer' operatic-numbat stable/bookstack

# Check if LoadBalancer service was created
kubectl get services


# Check helm releases
helm list

# Delete helm release
helm delete operatic-numbat

```

# Control how helm releases are installed through values.yaml file

```buildoutcfg
# Download values.yaml and edit localy 
wget https://raw.githubusercontent.com/helm/charts/master/stable/bookstack/values.yaml

# Edit values.yaml file (set service type to LoadBalancer instead of ClusterIP)
# Install bookstack app
helm install -f values.yaml stable/bookstack --name mybooks

# Check status
helm status mybooks
```


# Cleanup
```buildoutcfg
GKE-acloudgurugcloud beta container clusters delete standard-cluster-1 -q
```