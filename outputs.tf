output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_instance_ip_web1" {
  value = aws_instance.web1.public_ip
}

output "public_instance_ip_web2" {
  value = aws_instance.web2.public_ip
}

output "db_endpoint" {
  value = aws_db_instance.db.endpoint
}
