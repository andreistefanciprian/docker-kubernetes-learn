

```buildoutcfg

# define variables
export PROJECT_ID=aerial-utility-246511
export MY_ZONE=europe-west1-c

# build GKE cluster
gcloud container clusters create myapp --zone $MY_ZONE --num-nodes 2 --disk-size "20" --machine-type "n1-standard-1"
# authenticate GKE cluster
gcloud container clusters get-credentials myapp --zone=$MY_ZONE

# build and push image to Google Container Register
gcloud builds submit --config cloudbuild.yaml .

# deploy app
kubectl apply -f myapp-deployment.yaml
kubectl apply -f myapp-service.yaml


# access myapp at http://LB_IP:8080
# cleanup
kubectl delete deployment myapp-deployment
kubectl delete service myapp-service
gcloud beta container clusters delete --zone $MY_ZONE myapp -q


```