# Running a StatefulSet Cassandra database in a zone GKE cluster

# Part 1: Lab Objectives:


### Create a standard 3 node GKE cluster with n1-standard-2 instances
```buildoutcfg
gcloud container clusters create "cluster-1" --zone "europe-west2-c" --machine-type "n1-standard-2" --num-nodes "3"
```

### Authenticate kubectl with gcloud
```buildoutcfg
gcloud container clusters get-credentials cluster-1 --zone=europe-west2-c
```

### Deploy a StatefulSet to run Cassandra
```buildoutcfg
GKE-acloudgurukubectl apply -f ssd-class.yaml
kubectl apply -f cassandra-service.yaml

# Check resources
kubectl get services
kubectl get storageclasses
kubectl get svc,sc


# Appply StatefulSet
kubectl apply -f cassandra-statefulset.yaml

# Check DB state
kubectl exec -it cassandra-0 -- nodetool status

# Deploy container to perform DNS checks
kubectl run dig --image=tutum/dnsutils --restart=Never --rm=true --tty --stdin --command -- dig cassandra.default.svc.cluster.local

# Check persistent volumes after scaling down the number of replicas in cassandra db from 4 to 3
kubectl get pv

```

### 
```buildoutcfg
# Get cassandra-1 pod node name
kubectl get pods -o wide

# Mark node as unschedulable
kubectl cordon gke-cluster-1-default-pool-6055f530-0drd

# Delete pod
kubectl delete pod cassandra-1

# After pod is deleted, the scheduler will rebuild a new pod with the same name and associate it to the same persistent disk
kubectl get pv

```

# Cleanup
```buildoutcfg
GKE-acloudgurugcloud container clusters delete cluster-1 -q
```

# Part 2: Lab Objectives:

### Create regional GKE Cluster
```buildoutcfg
gcloud beta container clusters create "standard-cluster-1" \
--region "europe-west2" \
--machine-type "n1-standard-2" \
--image-type "UBUNTU" \
--num-nodes "1"
```

### Authenticate kubectl with gcloud
```buildoutcfg
gcloud container clusters get-credentials standard-cluster-1 --region=europe-west2
```

### Download Rook (storage orchestrator)
```buildoutcfg
wget https://github.com/rook/rook/archive/v1.0.6.zip
unzip v1.0.6.zip
cd rook-1.0.6/cluster/examples/kubernetes/ceph/
# Configure FLEXVOLUME_DIR_PATH in rook-1.0.6/cluster/examples/kubernetes/ceph/operator.yaml
         - name: FLEXVOLUME_DIR_PATH
          value: "/home/kubernetes/flexvolume"

kubectl create -f rook-1.0.6/cluster/examples/kubernetes/ceph/common.yaml
# Create rook operator
kubectl create -f rook-1.0.6/cluster/examples/kubernetes/ceph/operator.yaml

kubectl -n rook-ceph get pods

# Create ceph cluster
kubectl create -f ceph-cluster.yaml

# Create ceph storage class
kubectl create -f ceph-class.yaml

# Redeploy Cassandra
kubectl apply -f cassandra-service.yaml
kubectl apply -f cassandra-statefulset.yaml
```

# Cleanup
```buildoutcfg
# Delete GKE Cluster
gcloud container clusters delete standard-cluster-1 -q
```