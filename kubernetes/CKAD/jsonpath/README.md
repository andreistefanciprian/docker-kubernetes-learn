```buildoutcfg
# create resources
kubectl run nginx --image nginx --restart=Never --port 80
kubectl run busybox --image busybox --restart=Never -- /bin/sh -c "sleep 3600"

# get ip addresses of all pods 
kubectl get pods -o jsonpath="{.items[*].status.podIP}"
kubectl get pods -o jsonpath="{.items[*][ '.status.podIP', '.metadata.name' ]}"
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.hostIP}{"\n"}{end}'
```