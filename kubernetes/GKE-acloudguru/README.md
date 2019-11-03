# Course GKE Beginner to Pro from https://acloud.guru


# Prereguisites
Verify GKE and Container Registry APIs are enabled in GCP

# Run a simple nginx server on GKE
```buildoutcfg
# define variables
export MY_ZONE=us-central1-a

# build cluster
gcloud container clusters create webfrontend --zone $MY_ZONE --num-nodes 2
# authenticate cluster
gcloud container clusters get-credentials webfrontend --zone=$MY_ZONE

# build nginx deployment
kubectl run nginx --image nginx:1.10.0
# verify deployment
kubectl get pods
# expose deployment so nginx can be accessed from internet
kubectl expose deployment nginx --port 80 --type LoadBalancer
# verify service was build
kubectl get services
# scale deployment
kubectl scale deployment nginx --replicas 3

GKE-acloudgurukubectl delete deployment nginx
kubectl delete service nginx
gcloud beta container clusters delete webfrontend -q

```