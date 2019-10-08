# Healthchecks


 
### Healthchecks for containers

There are three container states: starting, healthy, unhealthy

```buildoutcfg

# Run containers
docker container run --name p1 -d postgres
docker container run --name p2 --health-cmd='pg_isready -U postgres || exit 1' -d postgres

# Check healthcheck
docker container ls
docker container inspect p2

```

### Healthchecks for docker services

There are three service states: preparing, starting, running
```buildoutcfg

# Create services
docker service create --name p1 postgres
docker service create --name p2 --health-cmd='pg_isready -U postgres || exit 1' postgres

```