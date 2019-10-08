

```buildoutcfg

# Build service
docker service create -p 8080:80 --name web nginx:1.13.7

# Increase number of replicas
docker scale web=5


# Change image (rolling update)
docker service update --image nginx:latest web

# Change port
docker service update --publish-rm 8080 --publish-add 9090:80 web

# Remove service
docker service rm `docker service ls -q`

```