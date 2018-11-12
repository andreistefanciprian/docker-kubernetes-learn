# clone docker repo
#git clone -b v0.1 https://github.com/jleetutorial/dockerapp.git

# Build Docker image
docker build -t dockerapp:v0.1 .

# Run Docker image
docker run -d -p 5000:5000 <CONTAINER ID>

# Access Docker app
http://<IP ADDRESS>:5000
