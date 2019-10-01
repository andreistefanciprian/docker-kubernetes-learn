```buildoutcfg
# Create containers in dettached mode
docker-compose up -d

# Create containers and build images
docker-compose up --build

# Stop containers
docker-compose down

# Stop containers and remove attached volumes
docker-compose down -v

# Stop containers and remove all used images
docker-compose down --rmi all

# Logs
docker-compose logs -f

# List containers
docker-compose ps

# Display running processes
docker-container top

```