## Define variables
PROJECT=cedar-card-200213

## Create GCP VPC Network and Subnet
gcloud compute --project=$PROJECT networks create network-docker --subnet-mode=custom
gcloud compute --project=$PROJECT networks subnets create subnet-docker --network=network-docker --region=europe-west2 --range=192.168.90.0/24

## Create GCP Firewall Rules
gcloud compute --project=$PROJECT firewall-rules create docker-allow-ports --direction=INGRESS --priority=1000 --network=network-docker --action=ALLOW --rules=tcp:22,icmp --source-ranges=0.0.0.0/0 --target-tags=docker
gcloud compute --project=$PROJECT firewall-rules create docker-allow-ports-egress --direction=EGRESS --priority=1000 --network=network-docker --action=ALLOW --rules=all --destination-ranges=0.0.0.0/0 --target-tags=docker

## Create GCP Compute Instances
gcloud beta compute --project=$PROJECT instances create docker-learn --machine-type=f1-micro --subnet=subnet-docker --tags=docker --image=ubuntu-minimal-1804-bionic-v20181030 --image-project=ubuntu-os-cloud



## Delete setup in this order
gcloud beta compute --project=$PROJECT instances delete docker-learn --quiet
gcloud compute --project=$PROJECT firewall-rules delete docker-allow-ports
gcloud compute --project=$PROJECT firewall-rules delete docker-allow-ports-egress
gcloud compute --project=$PROJECT networks subnets delete subnet-docker
gcloud compute --project=$PROJECT networks delete network-docker
