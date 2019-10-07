
```buildoutcfg

# Create overlay network
docker network create --driver overlay mydrupal

# List created network
docker network ls

# Create postgres service
docker service create --name psql --network mydrupal -e POSTGRES_PASSWORD=mypass postgres

# Create postgres service
docker service create --name drupal --network mydrupal -p 80:80 drupal

# List created service
docker service ls
docker service ps psql
docker service ps drupal


```

```buildoutcfg

docker service create --name search --replicas 3 -p 9200:9200 elasticsearch:2

```