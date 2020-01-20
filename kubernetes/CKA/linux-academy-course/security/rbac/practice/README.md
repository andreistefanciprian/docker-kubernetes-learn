



```buildoutcfg
kubectl create namespace web
kubectl create serviceaccount admin -n web
kubectl run curl --image curlimages/curl --restart Never --serviceaccount admin --image-pull-policy IfNotPresent --dry-run -o yaml --command -- sleep 3600

kubectl run nginx --image nginx --restart Never --image-pull-policy IfNotPresent

# test 1
kubectl create clusterrole cr --verb=list,get,watch --resource=pods
kubectl create clusterrolebinding crb1 --clusterrole=cr --serviceaccount=web:admin

kubectl create clusterrolebinding crb2 --clusterrole=cr --group=system:authenticated --group=system:unauthenticated

kubectl create clusterrolebinding crb3 --clusterrole=cr --group=system:serviceaccounts:web

kubectl exec -ti curl -c curl -n web -- curl localhost:8001/api/v1/namespaces/default/pods

```