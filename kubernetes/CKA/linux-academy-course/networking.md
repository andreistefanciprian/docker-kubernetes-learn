
## Inter pod communication
```buildoutcfg
# See which node our pod is on: 
kubectl get pods -o wide

# Log in to the node:
ssh [node_name]

# View the node's virtual network interfaces:
ifconfig

# View the containers in the pod:
docker ps

# Get the process ID for the container:
docker inspect --format '{{ .State.Pid }}' [container_id]

# Use nsenter to run a command in the process's network namespace:
nsenter -t [container_pid] -n ip addr


```

## Services

```buildoutcfg
# View the list of services in your cluster:
kubectl get services

# View the list of endpoints in your cluster that get created with a service:
kubectl get endpoints

# Look at the iptables rules for your services:
sudo iptables-save | grep KUBE | grep nginx

# Look up the DNS names
kubectl exec -ti busybox -- nslookup 10-244-2-5.default.pod.cluster.local
kubectl exec -ti busybox -- nslookup nginx.default.svc.cluster.local

# View the resolv.conf file that contains the nameserver and search in DNS:
kubectl exec -it busybox -- cat /etc/resolv.conf

```