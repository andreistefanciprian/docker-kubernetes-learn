```buildoutcfg

# configmap
kubectl create configmap my-cm1 --from-literal=key1=value1 --from-literal=key2=value2
kubectl create configmap my-cm2 --from-file=config.txt
kubectl create configmap my-cm3 --from-env-file=file.env

# secrets
kubectl create secret generic my-secret --from-literal=username=user --from-literal=password=mypassword
kubectl create secret generic my-secret2 --from-file=./secrets
kubectl create secret generic ssh-key-secret --from-file=private_key=$HOME/.ssh/id_rsa --from-file=public_key=$HOME/.ssh/id_rsa.pub


# sa
kubectl create serviceaccount admin

```