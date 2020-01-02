

```buildoutcfg

kubectl version

# verify control plane status
kubectl get componentstatus

kubectl cluster-info

kubectl config view

kubectl api-resources -o wide

# View the kube-config
cat .kube/config 


# List the services in the namespace via API call:
curl localhost:8001/api/v1/namespaces/my-ns/services

# View the token file from within a pod:
cat /var/run/secrets/kubernetes.io/serviceaccount/token

# check API access
kubectl auth can-i create deployments --namespace my-ns
kubectl auth can-i list secrets --namespace dev --as dave

```