

## Create k8s cluster in GCP

```buildoutcfg

export CLUSTER_NAME=hello-istio
export CLUSTER_ZONE=europe-west1-c

gcloud beta container clusters create $CLUSTER_NAME \
    --zone $CLUSTER_ZONE --num-nodes 1 \
    --machine-type "n1-standard-2" --disk-size 20GB\
    --enable-autoscaling --min-nodes 1 --max-nodes 2

# Verify cluster was built correctly
gcloud container clusters describe $CLUSTER_NAME

# authenticate kubectl with cluster
gcloud container clusters get-credentials $CLUSTER_NAME --zone=$CLUSTER_ZONE

# install istio

# label namespace to automatically injet sidecar container to each pod when your app is deployed
kubectl label ns default istio-injection=enabled  


# tests
APP_ADDRESS=34.77.231.234
cmd="curl --header 'x-myval: 192' http://${APP_ADDRESS}:30080/api/vehicles/driver/City%20Truck"
while true; do $cmd; echo; sleep 0.5; done

while true; do curl -s http://${INGRESS_GATEWAY}/ | grep -o "<title>.*</title>"; sleep 0.5; done

while true; do curl -s http://${NODE_ADDRESS}:31380/ | grep -o "<title>.*</title>"; sleep 0.5; done

while true; do curl -s --header "x-end-user: jason" http://${INGRESS_GATEWAY}/ | grep -o "<title>.*</title>"; sleep 0.5; done

# test circuit braker
while true; do curl -s http://${INGRESS_GATEWAY}/api/vehicles/driver/City%20Truck; sleep 0.5; echo; done

```



```buildoutcfg

kubectl get virtualservices
kubectl get vs

kubectl get destinationroutes
kubectl get dr


```
## Cleanup

```buildoutcfg

gcloud container clusters delete $CLUSTER_NAME -q
```