```buildoutcfg

# build image v1
docker build -t node-app:v1 .

# run container image
docker run --name node-app -p 8080:8080 -d node-app:v1
curl localhost:8080

# delete image
docker stop node-app
docker rm node-app

# push image to docker hub
docker tag node-app:v1 andreistefanciprian/node-app:v1
docker push andreistefanciprian/node-app:v1

# run docker image from docker hub
docker run --name node-app -p 8080:8080 -d andreistefanciprian/node-app:v1
curl localhost:8080

# test
kubectl run node-app --image andreistefanciprian/node-app:v1 --port 8080 --restart Never --expose
kubectl run busybox --image busybox --restart Never --rm -ti -- /bin/sh -c "while true; do wget -q -O- node-app.default.svc.cluster.local:8080; done"

# build image v2
docker build -t node-app:v2 .
docker tag node-app:v2 andreistefanciprian/node-app:v2
docker push andreistefanciprian/node-app:v2

# build image v3
docker build -t node-app:v3 .
docker tag node-app:v3 andreistefanciprian/node-app:v3
docker push andreistefanciprian/node-app:v3

# build deployment and service
kubectl run node-app --image andreistefanciprian/node-app:v1 --port 8080 -l app=node-app --record
kubectl create service nodeport node-app --tcp 8080:8080 --node-port 30001
while true; do curl localhost:30001; sleep 1; done

# scale deployment
kubectl scale deployment node-app --replicas 3
kubectl set image deployment node-app node-app=node-app:v2 --record

# canary update
kubectl run node-app-canary --image andreistefanciprian/node-app:v3 --port 8080 -l app=node-app --record
kubectl set image deployment node-app node-app=node-app:v3 --record

# rollout commands
kubectl rollout history deployment node-app
kubectl rollout status deployment node-app
kubectl rollout undo deployment node-app
kubectl rollout undo --torevision 3 deployment node-app

```