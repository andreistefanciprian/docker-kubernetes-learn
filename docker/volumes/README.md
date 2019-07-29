# Volumes
```buildoutcfg
docker volume ls
docker volume inspect

# Remove unused volumes
docker volume prune

# Start container with named volume
docker container run -d --name mysql -p 3306:3306 -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -v mysql-db:/var/lib/mysql mysql

# Start container with Bind mounting
docker container run -d --name nginx -p 80:80 -v $(pwd):/usr/share/nginx/html nginx

```


# postgresql db migration with named volumes
```buildoutcfg
# Create a new container running postgresql v 9.6.1
docker container run -d --name postgres1 -p 5432:5432 -e POSTGRES_PASSWORD=pass123 -v my-data:/var/lib/postgresql/data postgres:9.6.1

# Get ip address of postgres1
db_address=`docker container inspect --format '{{ .NetworkSettings.IPAddress }}' postgres`

# Connect to postgres1 and create DB (CREATE DATABASES testdb;)
docker run -it --rm postgres psql -U postgres -h $db_address

# Stop and remove postgres1 container
docker container rm -f posgres1

# Create a new container running postgresql v 9.6.2
docker container run -d --name postgres2 -p 5432:5432 -e POSTGRES_PASSWORD=pass123 -v my-data:/var/lib/postgresql/data postgres:9.6.2

# Connect to postgres2 and verify testdb is present
docker run -it --rm postgres psql -U postgres -h `docker container inspect --format '{{ .NetworkSettings.IPAddress }}' postgres`
```