# Swarm Secrets

```buildoutcfg

# Create secrets from file or from STIN
docker secret create psql_user psql_user.txt
echo "myDbPassword" | docker secret create psql_pass -

# Display secret details
docker secret ls
docker secret inspect psql_user

# Create service using swarm secrets
docker service create \
--name psql \
--secret psql_user \
--secret psql_pass \
-e POSTGRES_PASSWORD_FILE=/run/secret/psql_user \
-e POSTGRES_USER_FILE=/run/secret/psql_user \
postgres

# Use secrets with stack
docker stack deploy -c postgresql_stack_service_with_secrets.yml mydb
docker stack rm mydb



```