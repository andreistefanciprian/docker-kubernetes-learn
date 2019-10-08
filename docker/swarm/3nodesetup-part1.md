# Create VM Nodes in GCP
```

# Define project
PROJECT=`gcloud info | grep project | cut -d [ -f2 | cut -d] -f1`

# Define list of nodes
nodes=(node1 node2 node3)

# Create instances with docker installed
for node in ${nodes[*]}
do
	gcloud beta --project=$PROJECT \
	compute instances create ${node} \
	--zone=europe-west2-c \
	--machine-type=f1-micro \
	--subnet=default \
	--tags=http-server,https-server \
	--image=ubuntu-1804-bionic-v20191002 \
	--image-project=ubuntu-os-cloud \
	--metadata-from-file=startup-script=startup-script.sh
done

# Create GCP firewall rule to allow swarm docker communication between devices
gcloud compute \
--project=$PROJECT \
firewall-rules create docker-swarm \
--direction=INGRESS \
--priority=1000 \
--network=default \
--action=ALLOW \
--rules=tcp:2377,tcp:7946,udp:7946,udp:4789 \
--source-ranges=0.0.0.0/0
```

# Initialize docker swarm on node1
```
docker swarm init --advertise-addr 10.154.0.58

# Join swarm from node2
docker swarm join --token SWMTKN-1-06tfta00pjkfo2x43t031fh57zw24c87cezdnzfhuxpszb0epb-bg980ljruavjrrxph3pnvxgze 10.154.0.58:2377

# List docker nodes
docker node ls      # node1

# Promote node2 to manager role
docker node update --role manager node2

# Join swarm from node3 as manager
# Execute command on node1
docker swarm join-token manager
# Execute command on node3
docker swarm join --token SWMTKN-1-06tfta00pjkfo2x43t031fh57zw24c87cezdnzfhuxpszb0epb-6inam9l43s54vguhfqujs28f8 10.154.0.58:2377

```

# Create docker services
```buildoutcfg
docker service create --replicas 3 alpine ping 8.8.8.8

# Display running containers
docker node ps
docker node ps node2
docker node ps node3

# Display full list of container running on all nodes
docker service ps SERVICE_NAME

# Update docker service 
docker service update keen_hermann --replicas 4

docker service ls

```

# Delete VM Nodes
```

PROJECT=`gcloud info | grep project | cut -d [ -f2 | cut -d] -f1`
nodes=(node1 node2 node3)

for node in ${nodes[*]}
do
	gcloud beta --project=$PROJECT \
	compute instances delete ${node} --quiet
done
```