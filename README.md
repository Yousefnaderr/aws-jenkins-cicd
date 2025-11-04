This project demonstrates a complete DevOps environment deployed on AWS.
It includes infrastructure automation, CI/CD pipelines, and a full monitoring stack.

The setup contains four main parts:

1. Terraform Infrastructure
Terraform is used to provision AWS resources such as VPC, subnets, EC2 instances, IAM roles, ECR repository, and security groups.
It automates the creation of the backend server environment and Jenkins instance.

2. Jenkins CI/CD
Jenkins handles the continuous integration and delivery pipeline.
It builds and tests the small backend Python app, creates a Docker image, pushes it to AWS ECR, and triggers Terraform for deployment.
The Jenkins pipeline is defined inside the Jenkinsfile and runs automatically on code updates.

3. Monitoring Stack (Prometheus & Grafana)
Prometheus collects and stores metrics from the host machine and Docker containers.
Grafana provides visualization dashboards to monitor CPU, memory, disk usage, and system performance.
Node Exporter is used to expose host-level metrics to Prometheus.
Grafana connects to Prometheus as a data source and displays the Node Exporter Full dashboard.

4. Small Backend Application
A simple Python application containerized using Docker.
It serves as a demo service for testing CI/CD pipelines and monitoring integration.

Main Tools Used
AWS, Terraform, Jenkins, Docker, Prometheus, Grafana, and Node Exporter.

Project Summary

Terraform provisions the AWS environment automatically.

Jenkins builds, tests, and deploys the backend application.

Prometheus and Grafana monitor the infrastructure in real time.

Node Exporter provides system-level metrics from the EC2 instance.

Everything runs on Docker and can be deployed with a few commands.

Access Points
Grafana runs on port 3000, and Prometheus runs on port 9090.
Both can be accessed via the EC2 public IP address.
