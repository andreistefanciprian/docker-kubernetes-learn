

```buildoutcfg
# assignment drupal
echo "myDbPassword" | docker secret create psql-pw -
docker stack deploy -c assignment-drupal.yml drupal
```