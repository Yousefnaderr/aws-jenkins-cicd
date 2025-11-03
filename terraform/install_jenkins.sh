#!/bin/bash
# ===============================================================
# Jenkins setup script for AWS EC2 (Ubuntu 22.04)
# ===============================================================

set -e
echo "==== Starting Jenkins installation on $(hostname) ===="

# Update & upgrade
apt update -y && apt upgrade -y

# Install dependencies
apt install -y openjdk-17-jre-headless git docker.io curl apt-transport-https ca-certificates gnupg lsb-release

# Add Jenkins repo
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ \
  | tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
apt update -y && apt install -y jenkins

# Enable & start Jenkins
systemctl enable jenkins
systemctl start jenkins

# Add Jenkins and ubuntu users to docker group
usermod -aG docker jenkins || true
usermod -aG docker ubuntu || true
systemctl restart docker
systemctl restart jenkins

echo "==== Jenkins installed successfully ===="
echo "Public IP: $(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
echo "Initial Admin Password:"
cat /var/lib/jenkins/secrets/initialAdminPassword || true

