# Groupe de sécurité pour autoriser HTTP et SSH
resource "aws_security_group" "nginx_sg" {
  name        = "${var.name}-sg"
  description = "Autoriser HTTP et SSH"
  vpc_id      = var.vpc_id

  # Accès HTTP public
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Accès SSH limité
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-sg"
  }
}

# Instance EC2 avec NGINX
resource "aws_instance" "nginx" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_ids, 0)
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              sudo systemctl enable nginx
              sudo systemctl start nginx
              EOF

  tags = {
    Name = var.name
  }
}
