


```buildoutcfg

GKE-acloudgurugcloud beta container --project "google-project-name-here" \
clusters create "your-first-cluster-1" \
--zone "us-central1-a" \
--no-enable-basic-auth \
--cluster-version "1.14.6-gke.13" \
--machine-type "g1-small" \
--image-type "COS" \
--num-nodes "1" \
--enable-stackdriver-kubernetes \
--enable-ip-alias \
--network "projects/google-project-name-here/global/networks/default" \
--subnetwork "projects/google-project-name-here/regions/us-central1/subnetworks/default" \
--default-max-pods-per-node "110" \
--addons HorizontalPodAutoscaling,HttpLoadBalancing \
--enable-autoupgrade \
--enable-autorepair \
--no-shielded-integrity-monitoring

GKE-acloudgurugcloud container clusters get-credentials your-first-cluster-1 --zone=us-central1-a

# Run nginx pod
kubectl run nginx --image=nginx


kubectl get deployments
kubectl get pods

# Check recent events
kubectl get events

# Get more info abot deployment
kubectl describe deployment nginx

# Get more info abot pod
kubectl describe pod nginx-7db9fccd9b-5zqpm

#Expose port 80 
kubectl expose deployment nginx  --port=80 --type=LoadBalancer


# Get nginx logs 
kubectl logs pod/nginx-7db9fccd9b-5zqpm --follow

# Get logs only for particular selector. See logs for nginx on multiple pods..
kubectl logs --selector run=nginx --follow

# Simulate failures by overscaling 
kubectl scale --replicas=10 deployment nginx

# Scale back deployment
kubectl scale --replicas=2 deployment nginx

```