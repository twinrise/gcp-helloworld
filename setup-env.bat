@echo off
echo Starting environment setup...

echo Checking and removing existing cluster...
kind delete cluster --name gcp-helloworld-cluster

echo Checking and removing existing registry...
docker rm -f registry

echo Creating registry...
docker run -d --restart=always -p 5000:5000 --name registry --network kind registry:2

echo Creating Kind cluster...
kind create cluster --name gcp-helloworld-cluster --config kind-config.yaml

echo Connecting registry to Kind network...
docker network connect kind registry

echo Environment setup completed!
echo You can now run start-app.bat to deploy and run the application.
