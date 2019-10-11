# Kubernetes

```bash

# Check if kubernetes is installed
kubectl version


```

# Deploy pods (command line or YAML)

```text

# Create pod
kubectl run my-nginx --image nginx

# List pods
kubectl get pods

# List pods, replicaset and deployment services
kubectl get all

```

# Cleanup

```text
kubectl delete deployment my-nginx
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