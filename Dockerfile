# Start with a base image that includes necessary dependencies
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    openjdk-11-jre-headless

# Install Terraform
RUN wget -q https://releases.hashicorp.com/terraform/0.14.11/terraform_0.14.11_linux_amd64.zip \
    && unzip terraform_0.14.11_linux_amd64.zip -d /usr/local/bin \
    && rm terraform_0.14.11_linux_amd64.zip

# Install SonarQube
RUN wget -q https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.0.1.46107.zip \
    && unzip sonarqube-9.0.1.46107.zip -d /opt \
    && mv /opt/sonarqube-9.0.1.46107 /opt/sonarqube \
    && rm sonarqube-9.0.1.46107.zip

# Expose SonarQube ports
EXPOSE 9000

# Set environment variables for SonarQube
ENV SONAR_HOME=/opt/sonarqube
ENV PATH=$SONAR_HOME/bin:$PATH

# Start SonarQube
CMD ["sonar.sh", "start"]
