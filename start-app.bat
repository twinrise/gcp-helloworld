@echo off
echo Checking cluster status...
kind get clusters | findstr gcp-helloworld-cluster
if errorlevel 1 (
    echo Cluster not found! Please run setup-env.bat first.
    exit /b 1
)

echo Checking registry status...
docker ps | findstr registry
if errorlevel 1 (
    echo Registry not found! Please run setup-env.bat first.
    exit /b 1
)

echo Deploying application...
skaffold run

echo Setting up port forwarding...
start /B kubectl port-forward svc/gcp-helloworld 8080:8080

echo Application is starting...
echo You can access the application at http://localhost:8080
echo Press Ctrl+C to stop the application
