# Use the official Jenkins image as the base
FROM jenkins/jenkins:lts

# Set environment variable to disable the setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Set working directory
WORKDIR /var/jenkins_home

# Copy JCasC configuration file
COPY jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml

# Copy Jenkins startup script
COPY jenkins_setup.sh /var/jenkins_home/jenkins_setup.sh

# Switch to root user to change file permissions
USER root

# Grant execute permission to setup script
RUN chmod +x /var/jenkins_home/jenkins_setup.sh

# Install necessary utilities
RUN apt-get update && apt-get install -y curl netcat-openbsd

# Switch back to Jenkins user
USER jenkins

# Set the entrypoint to start Jenkins and execute the setup script
ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/jenkins.sh & /var/jenkins_home/jenkins_setup.sh && tail -f /dev/null"]

# Expose Jenkins ports
EXPOSE 8080 50000
