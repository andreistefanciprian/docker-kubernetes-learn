
### Build and authenticate GKE cluster

Done in previous lab.

### Pod reliability with health checks

```buildoutcfg

kubectl apply -f myapp-deployment.yaml
kubectl apply -f myapp-service.yaml

# Create IAM service account
gcloud iam service-accounts create cloudsqlproxy
# Assign permission to this service account with IAM policy binding
gcloud projects add-iam-policy-binding google-project-name-here \
--member serviceAccount:cloudsqlproxy@google-project-name-here.iam.gserviceaccount.com \
--role roles/cloudsql.client
# Create key to be used for auth
gcloud iam service-accounts keys create ./sqlproxy.json \
--iam-account cloudsqlproxy@google-project-name-here.iam.gserviceaccount.com

# Create kubernetes secret
kubectl create secret generic cloudsql-instance-credentials --from-file=credentials.json=./sqlproxy.json


# Create new container with cloud sqlproxy installed
kubectl apply -f myapp-deployment.yaml

# Check logs
kubectl get pods
kubectl logs pod/myapp-deployment-8578b88fdc-5589j -c cloudsql-proxy

# Enable mysql connection functionality for our app and rebuild docker image
docker build -t myapp:probes1 .
docker tag myapp:probes1 gcr.io/google-project-name-here/myapp:probes1
docker push gcr.io/google-project-name-here/myapp:probes1
```

```buildoutcfg

kubect describe pod PODNAME

kubectl rollout status deployment.v1.apps/myapp-deployment
kubect describe deployment myapp-deployment
```