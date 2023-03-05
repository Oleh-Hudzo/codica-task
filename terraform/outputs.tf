output "rds_endpoint" {
  value = aws_db_instance.wp-db-instance.endpoint
}

output "ip_for_ssh" {
  value = aws_instance.wp-instance.public_ip
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}
