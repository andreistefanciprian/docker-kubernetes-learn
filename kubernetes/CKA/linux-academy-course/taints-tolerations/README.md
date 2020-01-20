

```buildoutcfg

# taint node
kubectl taint nodes node1 node-type=prod:NoSchedule

# verify pod doesn't get deployment on node1
kubectl run nginx --image nginx --restart Always
kubectl scale deployment nginx --replicas 10

# verify pods get deployed on tainted node
kubectl apply -f tolerated-pods.yaml

```