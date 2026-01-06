output "instance_id" {
  value = aws_instance.nginx.id
}

output "public_ip" {
  value = aws_instance.nginx.public_ip
}

output "security_group_id" {
  value = aws_security_group.nginx_sg.id
}
