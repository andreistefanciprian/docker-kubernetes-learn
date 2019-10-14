
# YAML file parts
```yaml

apiVersion:

kind:
kubectl api-resources

apiVersion:
kubectl api-versions

metadata: 
# only the name is required here

spec: 

```

# Commands to discover specs

```buildoutcfg

# Get a list of all keys each kind supports
kubectl explain services --recursive

# Drill down into documentation of keys
kubectl explain services.spec
kubectl explain services.spec.type
kubectl explain deployment.spec.template.spec.volumes.nfs.server
```

# Apply YAMLs

```buildoutcfg

kubectl apply -f app.yml

```

# Dry-run and diff


```buildoutcfg

kubectl apply -f app.yml --dry-run
kubectl apply -f app.yml --server-dry-run


# Compare the specs on the server against the specs in the YAML file
kubectl diff -f app.yml

```


# Labels

```buildoutcfg

# Get list of pods by label filtering
kubectl get pods -l app=nginx

# Apply only matching labels
kubectl apply -f app.yaml -l app=nginx

```

# Cleanup

```buildoutcfg

kubectl delete -f app.yaml
```