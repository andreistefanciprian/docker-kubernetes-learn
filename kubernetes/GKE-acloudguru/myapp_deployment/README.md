# GKE Deployment

Build standard GKE cluster with three nodes (default settings)

Note: All commands to be executed in the GCP cloud shell

```buildoutcfg

# Authenticate kubectl with GKE
gcloud container clusters get-credentials standard-cluster-1 --zone=us-central1-a

# Build, tag and push image to Google Cloud Registry
docker build -t myapp .
docker tag myapp gcr.io/GCP_PROJECT_ID/myapp:blue
docker push gcr.io/GCP_PROJECT_ID/myapp:blue

# Change background color of template.html file to green and build and push new image to gcr.io
docker build -t myapp .
docker tag myapp gcr.io/GCP_PROJECT_ID/myapp:green
docker push gcr.io/GCP_PROJECT_ID/myapp:green

# Change background color of template.html file to green and build and push new image to gcr.io
docker build -t myapp .
docker tag myapp gcr.io/GCP_PROJECT_ID/myapp:green
docker push gcr.io/GCP_PROJECT_ID/myapp:green

# Deploy myapp
kubectl apply -f myapp-deployment.yaml

# Check if pods are running
kubectl get pods

# Check details about deployment
kubectl describe deployment myapp-deployment

# Apply LoadBalancer service
kubectl apply -f myapp-service.yaml

# Check pods distribution across nodes
kubectl get pods -o=custom-columns=NODE:.spec.nodeName,NAME:.metadata.name

# Taint a node - Tell scheduler not to use it!
kubectl taint nodes gke-standard-cluster-1-default-pool-0781c2df-jfmj key=value:NoSchedule

# Simulate a pod crash/failure for a pod that runs on the tainted node
kubectl delete pod POD_NAME

# Check pods distribution across nodes to verify that the new pod was not scheduled in the tainted pod

# Untaint node
kubectl taint nodes gke-standard-cluster-1-default-pool-0781c2df-jfmj key=NoSchedule-

# Redeploy app with bad image
kubectl apply -f myapp-deployment.yaml --record

# Check status and history of rollout
kubectl rollout status deployment.v1.apps/myapp-deployment
kubectl rollout history deployment.v1.apps/myapp-deployment

# Rollback to previous deployment
kubectl rollout undo deployment.v1.apps/myapp-deployment

```