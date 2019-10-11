# Kubernetes

```bash

# Check if kubernetes is installed
kubectl version


```

# Deploy pods (command line or YAML)

```text

# Create pod
kubectl run my-nginx --image nginx

```

# ReplicaSets

```text
# Create pod
kubectl run my-apache --image httpd


# Scale the pods (those are same command)
kubectl scale deploy/my-apache --replicas 2
kubectl scale deployment my-apache --replicas 2

```

# Inspect Kubernetes Objects

```text

# List pods
kubectl get pods

# List pods, replicaset and deployment services
kubectl get all

# Get container logs
kubectl logs deployment/my-apache

# Continuously display last line of the logs
kubectl logs deploy/my-apache --follow --tail 1

# Display logs from multiple pods that have the same label
kubectl logs -l run=my-apache

# Describe pod
kubectl describe pod/POD_NAME

```

# Delete pod

```text

# Delete pod
kubectl delete pod/POD_NAME

# Watch pod being recreated
kubectl get pods -w

```

# Cleanup

```text
kubectl delete deployment my-nginx
```


# Services
````
# Deploy deployment
kubectl create deployment httpenv --image bretfisher/httpenv

# Scale deployment
kubectl scale deployment/httpenv --replicas 5

# Create service (Creates ClusterIP service in front of deployement)
kubectl expose deployment/httpenv --port 8888 --type ClusterIP

# List service
kubectl get service

# Create another pod
kubectl run --generator=run-pod/v1 tmp-shell --rm -it --image bretfisher/netshoot -- bash
# Execute curl command inside container
curl httpenv:8888

# Create a NodePort service
kubectl expose deployment/httpenv --port 8888 --name htttpenv-np --type NodePort
curl 127.0.0.1:30204

# Build LB
kubectl expose deployment/httpenv --port 8888 --name htttpenv-lb --type LoadBalancer
curl 127.0.0.1:8888

# Remove services and objects
kubectl delete service/httpenv service/httpenv-np service/httpenv-lb deployment/httpenv
````