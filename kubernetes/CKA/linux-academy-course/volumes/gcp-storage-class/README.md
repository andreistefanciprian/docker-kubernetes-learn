
## Description

This is a scenario where a pod uses a GCP storage class.
Disk and PersistentVolume will be automatically provisioned.

https://kubernetes.io/docs/concepts/storage/storage-classes/#gce-pd
https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes

```buildoutcfg

# build resources
kubectl aplly -f .

# verify gcp disk and persistentvolume have been provisioned automatically
gcloud compute disks list
kubectl get pv
kubectl get pvc

# create a file in the pd volume inside the pod
kubectl exec -ti test-pd -- touch /test-pd/file1.txt
kubectl exec -ti test-pd -- ls /test-pd

# delete pod, rebuild it and verify file is still there
kubectl delete pod --all
kubectl aplly -f .
kubectl exec -ti test-pd -- ls /test-pd
```