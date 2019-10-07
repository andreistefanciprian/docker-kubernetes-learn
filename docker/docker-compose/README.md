```buildoutcfg
# Create containers in dettached mode
docker-compose up -d

# Create containers and build images
docker-compose up --build

# Build container only
docker-compose build

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

# Display running processes inside containers
docker-container top


# Debug a failing docker-compose file
docker-compose --verbose up

```