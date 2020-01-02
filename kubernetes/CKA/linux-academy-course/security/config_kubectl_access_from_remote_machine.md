

```buildoutcfg

# View the cluster config that kubectl uses:
kubectl config view

# View the config file:
cat ~/.kube/config

# Set new credentials for your cluster:
kubectl config set-credentials chad --username=chad --password=password

# Create a role binding for anonymous users (not recommended):
kubectl create clusterrolebinding cluster-system-anonymous --clusterrole=cluster-admin --user=system:anonymous

# SCP the certificate authority to your workstation or server:
scp ca.crt cloud_user@[pub-ip-of-remote-server]:~/

# Set the cluster address and authentication:
kubectl config set-cluster kubernetes --server=https://172.31.41.61:6443 --certificate-authority=ca.crt --embed-certs=true

# Set the credentials for Chad:
kubectl config set-credentials chad --username=chad --password=password

# Set the context for the cluster:
kubectl config set-context kubernetes --cluster=kubernetes --user=chad --namespace=default

# Use the context:
kubectl config use-context kubernetes

# Run the same commands with kubectl:
kubectl get nodes


```