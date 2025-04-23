#!/bin/bash

# Health check script for the application
LOG_FILE="health_checks.log"
APP_URL="http://localhost:5000"

echo "$(date) - Running health check..." | tee -a $LOG_FILE

# Wait for the application to start
sleep 5

# Check if the application is running by making an HTTP request
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

if [ $HTTP_STATUS -eq 200 ]; then
    echo "$(date) - Health check PASSED. Application is running (HTTP $HTTP_STATUS)" | tee -a $LOG_FILE
    exit 0
else
    echo "$(date) - Health check FAILED. Application is not responding properly (HTTP $HTTP_STATUS)" | tee -a $LOG_FILE
    
    # Optionally initiate automatic rollback if health check fails
    # Uncomment the next line to enable automatic rollback
    # ./rollback.sh
    
    exit 1
fi