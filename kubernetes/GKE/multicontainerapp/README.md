# Manually build pods inside GKE

Note: GKE Cluster has to be prebuilt
Note: All commands to be executed in the GCP cloud shell

```buildoutcfg

# Authenticate kubectl with GKE
gcloud container clusters get-credentials your-first-cluster-1 --zone=us-central1-a

# Build only one pod
kubectl apply -f nginx.yaml
kubectl port-forward nginx 8080:80

# Delete the pod
kubectl delete -f nginx.yaml

# Build the multi container pod
kubectl apply -f multi.yaml

# Get inside container
kubectl exec -it multi -c ftp-container -- /bin/bash

```