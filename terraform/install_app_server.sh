#!/bin/bash
# ===============================================================
# Application Server setup for AWS EC2 (Ubuntu 22.04)
# - Installs Docker + Docker Compose
# - Prepares for app + Prometheus + Grafana stack
# ===============================================================

set -e
echo "==== Starting Application Server setup on $(hostname) ===="

apt update -y && apt upgrade -y
apt install -y docker.io curl unzip

# Install Docker Compose (v2)
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Prepare app directory
mkdir -p /opt/app
cd /opt/app

cat <<'EOF' > docker-compose.yml
version: "3.9"

services:
  app:
    image: nginx:latest
    container_name: demo_app
    ports:
      - "80:80"

  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "3000:3000"
EOF

# Placeholder prometheus config
cat <<'EOF' > prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'demo_app'
    static_configs:
      - targets: ['app:80']
EOF

# Start all containers
docker-compose up -d

echo "==== Application Server setup complete ===="

