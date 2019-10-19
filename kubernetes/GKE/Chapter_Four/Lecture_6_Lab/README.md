# Multi GKE Cluster with one Ingress Controller Lab


# Lab Objectives

### Provision GKE Clusters in different zones
```buildoutcfg

KUBECONFIG=clusters.yaml gcloud container clusters create "cluster-1" --zone "europe-west2-c"
KUBECONFIG=clusters.yaml gcloud container clusters create "cluster-2" --zone "europe-west2-b"

# cluster.yaml saves the context for both GKEs. This will be used to run commands on both clusters at the same time
```

### Deploy zone-printer demo app
```buildoutcfg
ctxs=`kubectl config get-contexts -o=name --kubeconfig clusters.yaml`
for ctx in $ctxs; do kubectl --kubeconfig clusters.yaml --context="${ctx}" apply -f manifests/; done

# Monitoring
kubectl config --kubeconfig clusters.yaml current-context
kubectl config --kubeconfig clusters.yaml use-context CONTEXT_NAME

for ctx in $ctxs; do kubectl --kubeconfig clusters.yaml get deployments,svc; done

```

### Configure multi-cluster ingress

```buildoutcfg
# Grab kubemci
wget https://storage.googleapis.com/kubemci-release/release/latest/bin/linux/amd64/kubemci

gcloud compute addresses create --global kubemci-ip
gcloud compute addresses list

# Create ingress yaml
./kubemci create zone-printer --ingress=manifests/ingress.yaml --kubeconfig=clusters.yaml
./kubemci get-status zone-printer


```

# Cleanup
```buildoutcfg
# Delete GKE Cluster
gcloud beta container clusters delete standard-cluster-1 -q
gcloud container clusters delete "cluster-1" --zone "europe-west2-c" -q
gcloud container clusters delete "cluster-2" --zone "europe-west2-b" -q

gcloud compute addresses delete kubemci-ip -q

```