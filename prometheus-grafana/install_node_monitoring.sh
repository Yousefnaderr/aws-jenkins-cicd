#!/bin/bash
# install_node_monitoring.sh
set -e

echo ">>> Updating system and checking Docker..."
sudo apt-get update -y
sudo apt-get install -y docker.io docker-compose-plugin

echo ">>> Creating monitoring directories..."
sudo mkdir -p /opt/monitoring/{prometheus,data,grafana}
sudo chown -R ubuntu:ubuntu /opt/monitoring
cd /opt/monitoring

echo ">>> Creating Prometheus config..."
cat <<'EOF' > prometheus/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']
EOF

echo ">>> Creating Docker Compose file..."
cat <<'EOF' > docker-compose.yml
services:
  node-exporter:
    image: prom/node-exporter:v1.8.1
    restart: unless-stopped
    network_mode: host
    pid: host
    command:
      - --path.rootfs=/host
    volumes:
      - /:/host:ro,rslave

  prometheus:
    image: prom/prometheus:v2.54.1
    restart: unless-stopped
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - ./data:/prometheus
    command:
      - --config.file=/etc/prometheus/prometheus.yml
      - --storage.tsdb.path=/prometheus
      - --web.enable-lifecycle

  grafana:
    image: grafana/grafana:10.4.2
    restart: unless-stopped
    ports:
      - "3000:3000"
    volumes:
      - ./grafana:/var/lib/grafana
    environment:
      - GF_SECURITY_ADMIN_USER=admin
      - GF_SECURITY_ADMIN_PASSWORD=admin
EOF

docker compose up -d

echo "Prometheus: http://<YOUR-IP>:9090"
echo "Grafana: http://<YOUR-IP>:3000 (admin/admin)"

