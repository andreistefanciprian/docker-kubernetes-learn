

```buildoutcfg
# build image
docker build -t kubia .

# run container image
docker run --name kubia-container -p 8080:8080 -d kubia
curl localhost:8080

# delete image
docker stop kubia-container
docker rm kubia-container

# push image to docker hub
docker tag kubia andreistefanciprian/kubia
docker push andreistefanciprian/kubia

# run docker image from docker hub
docker run --name kubia-container -p 8080:8080 -d andreistefanciprian/kubia
curl localhost:8080

# delete container 

# run app as replicationcontroller
kubectl run kubia --image andreistefanciprian/kubia --port 8080 --generator=run/v1

# expose app as NodePort service
kubectl expose rc kubia --type=NodePort --port=8888 --target-port=8080
      
# scale rc
kubectl scale rc kubia --replicas 3

# test
while true; do curl localhost:30940; echo; sleep 1; done
kubectl run busybox --image busybox --restart=Never -ti --rm -- \
/bin/sh -c "while true; do wget -q -O- kubia:8888; echo; sleep 1; done"

kubectl run busybox --image busybox --restart=Never -ti --rm -- \
/bin/sh -c "while true; do wget -q -O- kubia.custom-namespace.svc.cluster.local:8888; echo; sleep 1; done"

# Forwarding a local network port to a port in the pod
kubectl port-forward pod/kubia-c77tq 9999:8080
curl localhost:9999

# To quickly switch to a different namespace, you can set up the following alias: 
alias kcd='kubectl config set-context $(kubectl config current-context) --namespace '
# You can then switch between namespaces using 
kcd some-namespace.

# delete rc but leave pods
kubectl delete rc kubia --cascade=false

```