variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "my_ip" {
  description = "Your public IP to allow SSH/Jenkins access (format x.x.x.x/32)"
  type        = string
}

variable "instance_type_jenkins" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3.small"
}

variable "instance_type_app" {
  description = "EC2 instance type for Application server"
  type        = string
  default     = "t3.small"
}

variable "ubuntu_ami_id" {
  description = "Ubuntu 22.04 AMI ID in the chosen region"
  type        = string
}

variable "key_pair_name" {
  description = "Name of an existing EC2 key pair to allow SSH"
  type        = string
}

variable "project_name" {
  description = "Name prefix for tagging and naming resources"
  type        = string
  default     = "aws-jenkins-cicd-demo"
}

