#!/bin/bash

# Deploy script for local environment
# This uses Ansible to deploy the application with blue-green deployment

echo "Starting deployment process..."

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed. Please install it first."
    exit 1
fi

# Run Ansible playbook for deployment
cd $(dirname "$0")/ansible
ansible-playbook -i inventory.ini deploy.yml

if [ $? -eq 0 ]; then
    echo "Deployment successful!"
    
    # Start the application in background
    cd ../production/active
    dotnet WebApp.dll --urls "http://localhost:5000" > ../app.log 2>&1 &
    
    echo $! > ../app.pid
    echo "Application started with PID: $(cat ../app.pid)"
    
    # Run health check
    ./health_check.sh
else
    echo "Deployment failed!"
    exit 1
fi