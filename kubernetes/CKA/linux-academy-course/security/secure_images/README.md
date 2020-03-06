
##

This scenario show the config needed to get images from https://gcr.io.

https://cloud.google.com/container-registry/docs/advanced-authentication
https://kubernetes.io/docs/concepts/containers/images/
https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account
```buildoutcfg

kubectl run myapp --image='gcr.io/google-project-name-here/flask-myapp:latest' --port 5000



export PROJECT=google-project-name-here
export KEY_NAME=docker-linuxacademy
export KEY_DISPLAY_NAME=”LinuxAcademyAcct”

# create and get the key
gcloud iam service-accounts create ${KEY_NAME} --display-name ${KEY_DISPLAY_NAME}
gcloud iam service-accounts list
gcloud iam service-accounts keys create --iam-account ${KEY_NAME}@${PROJECT}.iam.gserviceaccount.com key.json

# set iam permission
gcloud projects add-iam-policy-binding ${PROJECT} --member serviceAccount:${KEY_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/storage.admin

# Log in
sudo docker login -u _json_key -p "$(cat key.json)" https://gcr.io

sudo cat ~/.docker/config.json

# Push image to private registry
sudo docker pull busybox:1.28.4
sudo docker tag busybox:1.28.4 gcr.io/${PROJECT}/busybox:1.28.4
sudo docker push gcr.io/${PROJECT}/busybox:1.28.4

# Create a new docker-registry secret:
kubectl create secret docker-registry acr --docker-server=https://gcr.io --docker-username=_json_key --docker-password="$(cat key.json)" --docker-email=user@example.com

# Modify the default service account to use your new docker-registry secret:
kubectl patch sa default -p '{"imagePullSecrets": [{"name": "acr"}]}'
kubectl describe sa default

# clean
gcloud projects remove-iam-policy-binding ${PROJECT} --member serviceAccount:${KEY_NAME}@${PROJECT}.iam.gserviceaccount.com --role roles/storage.admin
gcloud iam service-accounts delete ${KEY_NAME}@${PROJECT}.iam.gserviceaccount.com -q
rm -f key.json
kubectl delete all --all
kubectl delete secret acr
# remove imagePullSecrets
kubectl edit serviceaccount default
sudo rm ~/.docker/config.json



```