#!/bin/bash

# build and push image to Google Container Register
gcloud builds submit --config cloudbuild.yaml .

# redeploy app
kubectl apply -f deployment.yaml

