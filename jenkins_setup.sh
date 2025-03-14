#!/bin/bash

# Wait for Jenkins to fully start
echo "Waiting for Jenkins to be fully available..."
while ! nc -z localhost 8080; do
    sleep 5
    echo "Jenkins is still starting..."
done

echo "Jenkins is up and running!"

# Move JCasC file to the correct location
mkdir -p /var/jenkins_home/jenkins.yaml
cp /var/jenkins_home/casc_configs/jenkins.yaml /var/jenkins_home/jenkins.yaml

# Set Jenkins environment variable to load JCasC
export CASC_JENKINS_CONFIG=/var/jenkins_home/jenkins.yaml

echo "JCasC Configuration applied successfully!"

