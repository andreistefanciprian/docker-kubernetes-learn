# Assignment: Create A Multi-Service Multi-Node Web App

## Goal: create networks, volumes, and services for a web-based "cats vs. dogs" voting app.
Here is a basic diagram of how the 5 services will work:

![diagram](./architecture.png)
- All images are on Docker Hub, so you should use editor to craft your commands locally, then paste them into swarm shell (at least that's how I'd do it)
- a `backend` and `frontend` overlay network are needed. Nothing different about them other then that backend will help protect database from the voting web app. (similar to how a VLAN setup might be in traditional architecture)
- The database server should use a named volume for preserving data. Use the new `--mount` format to do this: `--mount type=volume,source=db-data,target=/var/lib/postgresql/data`

### Services (names below should be service names)

- vote
    - dockersamples/examplevotingapp_vote:before
    - web front end for users to vote dog/cat
    - ideally published on TCP 80. Container listens on 80
    - on frontend network
    - 2+ replicas of this container

- redis
    - redis:3.2
    - key/value storage for incoming votes
    - no public ports
    - on frontend network
    - 1 replica NOTE VIDEO SAYS TWO BUT ONLY ONE NEEDED

- worker
    - dockersamples/examplevotingapp_worker
    - backend processor of redis and storing results in postgres
    - no public ports
    - on frontend and backend networks
    - 1 replica

- db
    - postgres:9.4
    - one named volume needed, pointing to /var/lib/postgresql/data
    - on backend network
    - 1 replica

- result
    - dockersamples/examplevotingapp_result:before
    - web app that shows results
    - runs on high port since just for admins (lets imagine)
    - so run on a high port of your choosing (I choose 5001), container listens on 80
    - on backend network
    - 1 replica


# Solution using nodes in GCP cloud

```buildoutcfg

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

# Create GCP firewall rule to allow port 5001, 80, 443
gcloud compute \
--project=$PROJECT \
firewall-rules create docker-custom-ports \
--direction=INGRESS \
--priority=1000 \
--network=default \
--action=ALLOW \
--rules=tcp:5001,tcp:80,tcp:443 \
--source-ranges=0.0.0.0/0

# Initialize docker swarm on node 1
docker swarm init --advertise-addr

# Join swarm from node2 and node3 as manager
# Execute command on node1
docker swarm join-token manager
# Execute command on node3
docker swarm join --token TOKEN 10.154.0.58:2377

# Create networks and services
docker network create --driver overlay frontend
docker network create --driver overlay backend


docker service create --replicas 2 --name redis --network frontend redis:3.2
docker service create --name db --network backend --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4

docker service create --replicas 2 --name vote --network frontend -p 80:80 dockersamples/examplevotingapp_vote:before
docker service create --name worker --network frontend --network backend dockersamples/examplevotingapp_worker
docker service create --name result --network backend -p 5001:80 dockersamples/examplevotingapp_result:before

```

# Or use docker stack to build the same setup

```buildoutcfg

docker stack deploy -c voting_app_stack.yml voteapp

docker stack ls
docker stack ps STACK_NAME
docker stack services STACK_NAME

```
