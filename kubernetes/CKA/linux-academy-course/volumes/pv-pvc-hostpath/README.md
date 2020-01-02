## Description

This is a scenario where a pod uses the local disk as persistent volume.

https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

```buildoutcfg

# create folder and file on the node where pod will be deployed
sudo mkdir /tmp/data
sudo sh -c "echo 'Hello from Kubernetes storage' > /tmp/data/index.html"

# test if index.html is available on pod
curl localhost:30001

# clean
kubectl delete all --all
```