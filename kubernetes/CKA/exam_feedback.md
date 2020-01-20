
* build pod with init container that creates a file and the main container verifies if file is there
* build cluster with kubeadm. There was a conflict when I ran kubeadm command because pod-network-cidr and ignore-preflight-errors aren't accepted together
```kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors --config=file.conf```
* create pod that exposes secret as volume and as env
* debug scenario where a node wasn't in Ready state. It has two taints that I have removed. Came back in Ready state.

* build deployment and pods and services
* test service and pod DNS with nslookup
* do a recorded deployment update and revert to previous revision
* no jobs or job schedulers or configmaps or statefulsets
* build daemonset
* sort CPU utilization of pods with specific label
* sorting and jsonpath a few times
* scale deployment
* create persistent volume (create a pod with a persistent volume but the volume must not be persistent???)
* build pod with 4 containers
* get logs from pod
* backup etcd with certs: https://github.com/mmumshad/kubernetes-cka-practice-test-solution-etcd-backup-and-restore
```buildoutcfg
ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
     snapshot save /tmp/snapshot-pre-boot.db
```
* build manual pod on node (static)
