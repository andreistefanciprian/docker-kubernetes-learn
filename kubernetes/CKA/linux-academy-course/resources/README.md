```buildoutcfg

## configure default cpu and memory requests and limits
kubectl apply -f default.yaml
kubectl get limitrange
kubectl describe limitrange cpu-mem-limit-range

# create pod without specifying memory and cpu resource requests or limits
kubectl run busybox --image busybox --restart Never --command dd if=/dev/zero of=/dev/null

# check if default cpu and memory requests and limits have been applied
kubectl describe pod busybox

## configure min and max cpu and memory requests and limits
kubectl apply -f default.yaml
kubectl get limitrange
kubectl describe limitrange

# ok
kubectl run busybox1 --image busybox --restart Never --requests cpu=200m,memory=200Mi --limits cpu=300m,memory=300Mi -- sleep 3600
kubectl run busybox2 --image busybox --restart Never --requests cpu=50m,memory=64Mi --limits cpu=300m,memory=300Mi -- sleep 3600

# not ok
kubectl run busybox3 --image busybox --restart Never --requests cpu=200m,memory=200Mi --limits cpu=301m,memory=301Mi -- sleep 3600
kubectl run busybox4 --image busybox --restart Never --requests cpu=49m,memory=63Mi --limits cpu=300m,memory=300Mi -- sleep 3600

## configure requests and limits resource quota
kubectl apply -f quota.yaml
kubectl get resourcequota
kubectl describe resourcequota

# ok
kubectl run busybox1 --image busybox --restart Never --requests cpu=200m,memory=200Mi --limits cpu=300m,memory=300Mi -- sleep 3600
kubectl run busybox2 --image busybox --restart Never --requests cpu=200m,memory=200Mi --limits cpu=300m,memory=300Mi -- sleep 3600

# not ok
kubectl run busybox3 --image busybox --restart Never --requests cpu=200m,memory=200Mi --limits cpu=300m,memory=300Mi -- sleep 3600

```