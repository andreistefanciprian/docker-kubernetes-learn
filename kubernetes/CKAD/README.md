## CKAD


## Build cluster
```buildoutcfg
# define variables
ZONE=europe-west1
GKE_NAME=linux-academy-cluster

# create cluster
gcloud beta container clusters create $GKE_NAME --num-nodes "1" --zone $ZONE --disk-size "20" --enable-ip-alias

# authenticate kubectl with cluster
gcloud container clusters get-credentials $GKE_NAME --zone=$ZONE

# resize cluster
gcloud container clusters resize $GKE_NAME --zone=$ZONE --num-nodes "1" -q

# delete cluster
gcloud container clusters delete $GKE_NAME --zone=$ZONE -q

```

```buildoutcfg

# get detailes about API objects
kubectl explain Pod.spec.containers.ports

# get list of API objects
kubectl get api-resources -o name

# get node yaml file
kubectl get nodes <node-name> -o yaml

# get yaml file for pod
kubectl run busybox --image=busybox --restart=Never --dry-run -o yaml -- /bin/sh -c "echo Hello Kubernetes! && sleep 3600" 

# edit pod
kubectl edit pod busybox
kubectl set image pod/<pod-name> <pod-name>=nginx

```
## Monitoring
```buildoutcfg

# node container logs
ls -larth /var/log/containers

# check logs of previous container if any
kubectl logs <pod-name> -c <container-name> --previous

# get container logs with timestamp
kubectl logs <pod-name> -c <container-name> -f --timestamps

# get logs from all containers within a pod
kubectl logs <pod-name> --all-containers


kubectl logs curl --tail 20
kubectl logs curl --since 1m
kubectl logs deployment/nginx -c nginx

# verify events
kubectl get events
kubectl get events --all-namespaces
kubectl get events --sort-by=.metadata.creationTimestamp

# sorting
kubectl get pods --sort-by='.metadata.annotations.my-annotation'

# get metrics from multi container pod
kubectl top pods
kubectl top pod <pod-name> 
kubectl top pod <pod-name> --containers

# get the top 3 CPU hungry pods
kubectl top pods --all-namespaces | sort --reverse --key 3 --numeric | head -3

#get metrics from nodes
kubectl top nodes
kubectl top node <nod-name>

# get Pod IP Address
kubectl get pod <pod-name> -o custom-columns=IP:.status.podIP --no-headers



kubectl get pods -l env=prod
kubectl get pods -l env=prod,env=dev
kubectl get pods -l env!=prod
kubectl get pods -l 'env in (prod,dev)'
kubectl get pods -l '!env'

```

## Deployments

```buildoutcfg

# generate yaml file
kubectl run nginx --image nginx --replicas 3 --restart=Always --port 80 --dry-run -o yaml --record
kubectl create deployment nginx --image nginx --dry-run -o yaml
kubectl run nginx --image=nginx --requests=cpu=200m,memory=100Mi --limits=cpu=500m,memory=200Mi --expose --port=80 --dry-run -o yaml

# update deployment
kubectl edit deployment nginx
kubectl set image deployment nginx nginx=nginx:1.9.1 --record
kubectl patch deployment kubeserve -p '{"spec": {"minReadySeconds": 10}}'

# see the Deployment rollout statu
kubectl rollout status deployment nginx

# see rollout history
kubectl rollout history deployment/nginx

# rollback to previous deployment
kubectl rollout undo deployment nginx
kubectl rollout undo --to-revision 1 deployment nginx

# see the details of specific revision
kubectl rollout history deployment nginx --revision 2

# pause deployment
kubectl rollout pause deployment nginx

# pause deployment
kubectl rollout resume deployment nginx

# see the ReplicaSet (rs) created by the Deployment
kubectl get replicasets

# see the labels automatically generated for each Pod
kubectl get pods --show-labels


# scaling
kubectl scale --replicas 4 -f deployment.yaml
kubectl scale --replicas 4 deployment nginx

# generate HorizontalPodAutoscaler yaml file
kubectl autoscale --min 1 --max 5 --cpu-percent 60 -f deployment.yaml --dry-run -o yaml
```

## Pod design

```buildoutcfg

# create pod with labels
kubectl run nginx --image nginx --labels=app=nginx,env=qa --restart=Never --dry-run -o yaml

# display label in it's own column
kubectl get pods -L app,env

# change label
kubectl label pod nginx env=uat --overwrite

# delete label
kubectl label pod nginx env-
kubectl label pod nginx{1..3} env-

# manage pod annotations
kubectl annotate pod nginx{1..3} name=webapp
kubectl annotate pod nginx{1..3} name-

# add label to node
kubectl label node node1 app=nginx

```

## Jobs

```buildoutcfg

# generate yaml
kubectl run busybox --image busybox --restart=OnFailure --dry-run -o yaml -- sleep 20
kubectl create job busybox --image busybox --dry-run -o yaml -- sleep 20

kubectl create cronjob busybox --image busybox --schedule="*/1 * * * *" --dry-run -o yaml -- sleep 20

```

## Services

```buildoutcfg

# create nginx deployment with clusterip service and test service
kubectl run nginx --image nginx --labels=app=nginx --restart Always --port 80 --dry-run -o yaml --record
kubectl create service nodeport nginx --tcp=8080:80 --node-port 30002
# verify services and endpoints
kubectl get svc
kubectl get endpoints
# test service
kubectl run busybox --image busybox --restart Never -it --rm -- /bin/sh -c "while true; do wget -q -O- http://nginx:8080; sleep 5; done"
kubectl run busybox --image busybox --restart Never -it --rm -- /bin/sh -c "while true; do wget -q -O- http://nginx.default.svc.cluster.local:8080; sleep 5; done"
curl <node-ip>:30002
# delete service and recreate it from command line
kubectl delete svc nginx
kubectl expose deployment nginx --name nginx --port 8080 --target-port 80 --type ClusterIP
# test service nginx
kubectl run busybox --image busybox --restart Never -it --rm -- /bin/sh -c "while true; do wget -q -O- http://nginx:8080; sleep 5; done"
# delete nginx service and create NodePort service
kubectl delete svc nginx
kubectl expose deployment nginx --port 80 --type NodePort --name nginx
# test service nginx
kubectl run busybox --image busybox --restart=Never -it --rm -- /bin/sh -c "while true; do wget -q -O- http://nginx:80; sleep 5; done"
curl <node-ip>:<nodeport>

```

## Cleanup

```buildoutcfg
# delete all resources within a namespace
kubectl delete all --all

# delete namespace including all it's resources
kubectl delete namespace custom-namspace

# delete all pods
kubectl delete pods --all

```

## Miscellaneous

```buildoutcfg

# configure kubectl to use a different editor
export KUBE_EDITOR="/usr/bin/vim"
```
