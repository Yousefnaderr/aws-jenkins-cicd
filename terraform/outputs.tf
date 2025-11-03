# =============================
# Terraform Outputs
# =============================

output "jenkins_public_ip" {
  description = "Public IP of Jenkins EC2 instance"
  value       = aws_instance.jenkins.public_ip
}

output "app_public_ip" {
  description = "Public IP of Application EC2 instance"
  value       = aws_instance.app.public_ip
}

output "ecr_repo_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app_repo.repository_url
}

