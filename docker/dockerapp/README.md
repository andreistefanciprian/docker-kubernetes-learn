```buildoutcfg

# Build image
docker build -t dockerapp:v0.1 .

# Run container with new nginx image
docker run -d -p 5000:5000 <CONTAINER ID>

# Access Docker app
http://<IP ADDRESS>:5000
```