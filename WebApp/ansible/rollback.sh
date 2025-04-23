#!/bin/bash

# Rollback script for local environment

echo "Starting rollback process..."

# Check if we have blue and green directories
if [ ! -d "production/blue" ] || [ ! -d "production/green" ]; then
    echo "Blue or Green deployment directories not found."
    exit 1
fi

# Stop the current application
if [ -f "production/app.pid" ]; then
    PID=$(cat production/app.pid)
    echo "Stopping application with PID: $PID"
    kill -15 $PID 2>/dev/null || true
    rm production/app.pid
fi

# Determine current and previous deployment
CURRENT_LINK=$(readlink -f production/active)
if [[ "$CURRENT_LINK" == *"blue"* ]]; then
    echo "Current deployment is BLUE, rolling back to GREEN"
    rm -f production/active
    ln -sf production/green production/active
else
    echo "Current deployment is GREEN, rolling back to BLUE"
    rm -f production/active
    ln -sf production/blue production/active
fi

# Start the previous version
cd production/active
dotnet WebApp.dll --urls "http://localhost:5000" > ../app.log 2>&1 &
echo $! > ../app.pid
echo "Application rolled back and started with PID: $(cat ../app.pid)"

# Run health check
cd ../..
./health_check.sh