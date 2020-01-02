```buildoutcfg

# get node out of service
kubectl drain <node-name> --ignore-daemonsets

# verify if node has scheduling disabled
kubectl get nodes

# put node back into service
kubectl uncordon <node-name>

# remove node from cluster
kubectl delete node <nde-name>

```