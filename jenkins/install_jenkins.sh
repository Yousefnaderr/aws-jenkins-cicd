#!/bin/bash

# Jenkins Installation Script for Ubuntu 22.04+
# Author: Youssef

set -e

echo "Starting Jenkins installation..."

# Update and upgrade system packages
sudo apt update -y && sudo apt upgrade -y

# Install Java (required for Jenkins)
echo "Installing OpenJDK 17..."
sudo apt install openjdk-17-jdk -y

# Verify Java installation
java -version || { echo "Java installation failed!"; exit 1; }

# Add Jenkins repository and import GPG key
echo "Adding Jenkins repository..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
echo "Installing Jenkins..."
sudo apt update -y
sudo apt install jenkins -y

# Enable and start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Configure firewall rules
sudo ufw allow 8080
sudo ufw allow OpenSSH
sudo ufw --force enable

# Check service status
sudo systemctl status jenkins | grep Active

# Display Jenkins initial admin password
echo "Jenkins installation complete."
echo "Access Jenkins using: http://<YOUR_PUBLIC_IP>:8080"
echo "Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "Done."

