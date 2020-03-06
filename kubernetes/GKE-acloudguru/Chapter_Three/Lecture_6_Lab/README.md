
# Persistent Storage and Volumes

```buildoutcfg

GKE-acloudgurugcloud beta container --project "google-project-name-here" \
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

GKE-acloudgurugcloud container clusters get-credentials standard-cluster-1 --zone=europe-west2-c


# Apply volume claims
kubectl apply -f mysql-volumeclaim.yaml
kubectl apply -f wordpress-volumeclaim.yaml

# Check if persistent volumes were created
kubectl get pvc

# Create mysql secret
kubectl create secret generic mysql --from-literal=password=MYSECRETPASS


# Apply mysql workload
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml

# Check workload has been built
kubectl get pods
kubectl get services
kubectl describe pod mysql-674dcfbd85-gnsw8
kubectl describe deployment mysql
kubectl logs -f pod/mysql-674dcfbd85-gnsw8

# Apply wordpress workload
kubectl apply -f wordpress-deployment.yaml
kubectl apply -f wordpress-service.yaml


###

# Write some data to wordpress blog

# Let's delete the mysql pod to prove our data is persistent after pod will be rebuilt

kubectl delete pod -l app=mysql


# Cleanup
kubectl delete -f mysql-service.yaml
kubectl delete -f wordpress-service.yaml
kubectl delete -f mysql-deployment.yaml
kubectl delete -f wordpress-deployment.yaml
kubectl delete -f mysql-volumeclaim.yaml
kubectl delete -f wordpress-volumeclaim.yaml
gcloud beta container clusters delete standard-cluster-1 -q

```

