

## Description

This is a scenario where a pod uses a GCP disk as persistent volume.

https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/#create-a-persistentvolume

```buildoutcfg

# create a GCP PD
gcloud compute disks create --size=1GB --zone=europe-west4-c my-data-disk

# create pod
kubectl apply -f pod-pv-pvc.yaml

# create a file in the pd volume inside the pod
kubectl exec -ti test-pd -- touch /test-pd/file1.txt
kubectl exec -ti test-pd -- ls /test-pd

# drain the node where pod resides
kubectl get nodes
kubectl drain <node-name> --ignore-daemonsets --force

# rebuild pod on a different node
kubectl apply -f pod.yaml

# verify file is still there
kubectl exec -ti test-pd -- ls /test-pd

# put node back into service
kubectl uncordon <node-name>

# clean
kubectl delete all --all
gcloud compute disks delete --zone=europe-west4-c my-data-disk -q

```