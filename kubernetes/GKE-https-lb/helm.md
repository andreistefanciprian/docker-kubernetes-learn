# install redis via helm

```bash

# create and authenticate cluster
gcloud container clusters create $my_cluster --num-nodes 3  --enable-ip-alias --zone $my_zone
gcloud container clusters get-credentials $my_cluster --zone $my_zone

# download helm
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.6.2-linux-amd64.tar.gz
tar zxfv helm-v2.6.2-linux-amd64.tar.gz -C ~/
cp linux-amd64/helm ~/

# Ensure your user account has the cluster-admin role in your cluster
kubectl create clusterrolebinding user-admin-binding \
   --clusterrole=cluster-admin \
   --user=$(gcloud config get-value account)
   
   
# Create a Kubernetes service account that is Tiller - the server side of Helm, can be used for deploying charts
kubectl create serviceaccount tiller --namespace kube-system

# Grant the Tiller service account the cluster-admin role in your cluster
kubectl create clusterrolebinding tiller-admin-binding \
   --clusterrole=cluster-admin \
   --serviceaccount=kube-system:tiller
   
# Execute the following commands to initialize Helm using the service account
~/helm init --service-account=tiller

# Execute the following commands to update the Helm repositories
~/helm repo update

# In Cloud Shell, execute the following command to verify the Helm installation and configuration
~/helm version

# deploy a set of resources to create a Redis service on the active context cluster
~/helm install --version=8.1.5 stable/redis

# inspect created objects
kubectl get services
kubectl get statefulsets
kubectl configmaps
kubectl get configmaps
kubectl get secrets

# inspect helm chart
~/helm inspect stable/redis

# If you want to see the templates that the Helm chart deploys you can use the following command
~/helm install --version=8.1.5 stable/redis --dry-run --debug

## Test redis functionality

# Execute the following command to store the service ip-address for the Redis cluster in an environment variable
export REDIS_IP=$(kubectl get services -l app=redis -o json | jq -r '.items[].spec | select(.selector.role=="master")' | jq -r '.clusterIP')

# Retrieve the Redis password and store it in an environment variable
export REDIS_PW=$(kubectl get secret -l app=redis -o jsonpath="{.items[0].data.redis-password}"  | base64 --decode)

# Display the Redis cluster address and password
echo Redis Cluster Address : $REDIS_IP
echo Redis auth password   : $REDIS_PW

# Open an interactive shell to a temporary Pod, passing in the cluster address and password as environment variables
kubectl run redis-test --rm --tty -i --restart='Never' \
    --env REDIS_PW=$REDIS_PW \
    --env REDIS_IP=$REDIS_IP \
    --image docker.io/bitnami/redis:4.0.12 -- bash

# Connect to the Redis cluster
redis-cli -h $REDIS_IP -a $REDIS_PW

# Set a key value
set mykey this_amazing_value

# Retrieve the key value
get mykey

```