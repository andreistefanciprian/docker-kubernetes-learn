```buildoutcfg

# create directory and index.html file on the node where pod will be deployed
mkdir /tmp/data
echo 'Hello from Kubernetes storage' > /mnt/data/index.html

# build resources
kubectl apply -f .

# verify
curl http://localhost:30001/
kubectl logs busybox -f --timestamps

# delete resources
kubectl delete pod busybox --now
kubectl delete pod task-pv-pod --now
kubectl delete pvc task-pv-claim --now
kubectl delete pv task-pv-volume --now
kubectl delete svc task-pv-pod --now

```