

```buildoutcfg

kubectl create namespace web

kubectl create role service-reader --verb=get --verb=list --resource=services --dry-run -o yaml > role.yaml
kubectl create rolebinding test --role=service-reader --serviceaccount=web:default -n web --dry-run -o yaml > role-binding.yaml

kubectl create clusterrole pv-reader --verb=get,list --resource=persistentvolumes --dry-run -o yaml > cluster-role.yaml
kubectl create clusterrolebinding pv-test --clusterrole=pv-reader --serviceaccount=web:default --dry-run -o yaml > cluster-role-binding.yaml

# Run a proxy for inter-cluster communications:
kubectl proxy

# Try to access the services in the web namespace:
curl localhost:8001/api/v1/namespaces/web/services

# Create the pod that will allow you to curl directly from the container:
kubectl apply -f curl-pod.yaml

# Get the pods in the web namespace:
kubectl get pods -n web

# Open a shell to the container:
kubectl exec -it curlpod -n web -- sh

# Access PersistentVolumes (cluster-level) from the pod:
curl localhost:8001/api/v1/persistentvolumes

```