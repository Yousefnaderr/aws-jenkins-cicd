# Jenkins EC2
resource "aws_instance" "jenkins" {
  ami                         = var.ubuntu_ami_id
  instance_type               = var.instance_type_jenkins
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.cicd_sg.id]
  key_name                    = var.key_pair_name
  iam_instance_profile        = aws_iam_instance_profile.jenkins_instance_profile.name
  associate_public_ip_address = true

  user_data = file("${path.module}/install_jenkins.sh")

  tags = {
    Name = "${var.project_name}-jenkins"
    Role = "jenkins-ci"
  }
}

# Application EC2
resource "aws_instance" "app" {
  ami                         = var.ubuntu_ami_id
  instance_type               = var.instance_type_app
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.cicd_sg.id]
  key_name                    = var.key_pair_name
  associate_public_ip_address = true

  user_data = file("${path.module}/install_app_server.sh")

  tags = {
    Name = "${var.project_name}-app"
    Role = "docker-runtime"
  }
}

