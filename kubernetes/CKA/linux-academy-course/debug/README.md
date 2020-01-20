

## Troubleshoot control plane failure


```buildoutcfg

# Check the events in the kube-system namespace for errors:
kubectl get events -n kube-system

# Get the logs from the individual pods in your kube-system namespace and check for errors:
kubectl logs [kube_scheduler_pod_name] -n kube-system

# Check the status of the Docker service:
sudo systemctl status docker

# Start up and enable the Docker service, so it starts upon bootup:
sudo systemctl enable docker && systemctl start docker

# Check the status of the kubelet service:
sudo systemctl status kubelet

# Start up and enable the kubelet service, so it starts up when the machine is rebooted:
sudo systemctl enable kubelet && systemctl start kubelet

# Turn off swap on your machine:
sudo su -
swapoff -a && sed -i '/ swap / s/^/#/' /etc/fstab

# Check if you have a firewall running:
sudo systemctl status firewalld

# Disable the firewall and stop the firewalld service:
sudo systemctl disable firewalld && systemctl stop firewalld

```

## Troubleshooting Worker Nodes

```buildoutcfg

# Listing the status of the nodes should be the first step:
kubectl get nodes

# Find out more information about the nodes with kubectl describe:
kubectl describe nodes chadcrowell2c.mylabserver.com

# You can try to log in to your server via SSH:
ssh chadcrowell2c.mylabserver.com

# Get the IP address of your nodes:
kubectl get nodes -o wide

# Use the IP address to further probe the server:
ssh cloud_user@172.31.29.182

# Generate a new token after spinning up a new server:
sudo kubeadm token generate

# Create the kubeadm join command for your new worker node:
sudo kubeadm token create [token_name] --ttl 2h --print-join-command

# View the journalctl logs:
sudo journalctl -u kubelet

# View the syslogs:
sudo more syslog | tail -120 | grep kubelet
```

## Troubleshooting networking

```buildoutcfg
# Check if kube-proxy is running on the nodes:
ps auxw | grep kube-proxy

# View the list of kube-system pods:
kubectl get pods -n kube-system

# Connect to your kube-proxy pod in the kube-system namespace:
kubectl exec -it kube-proxy-cqptg -n kube-system -- sh

# Check if kube-proxy is writing iptables:
iptables-save | grep hostnames

# Delete the flannel CNI plugin:
kubectl delete -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml

# Apply the Weave Net CNI plugin:
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```