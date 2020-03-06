```bash


# define variables
export PROJECT_ID=google-project-name-here
#export MY_ZONE=europe-west1-c
export MY_REGION=europe-west1

# build GKE cluster
gcloud container clusters create myapp \
--region $MY_REGION --num-nodes 1 --disk-size "20" --machine-type "n1-standard-1" \
--enable-autoscaling --min-nodes "1" --max-nodes "3"

# authenticate GKE cluster
gcloud container clusters get-credentials myapp --region $MY_REGION

# build and push image to Google Container Register
gcloud builds submit --config cloudbuild.yaml .

# deploy app
kubectl apply -f deployment.yaml

# access myapp at http://LB_IP:8080

# cleanup
kubectl delete deployment myapp
kubectl delete service myapp-svc
gcloud beta container clusters delete --region $MY_REGION myapp -q

# manually build and run docker
docker build -f Dockerfile -t hello-python:latest .
docker run -p 5001:5000 hello-python



```