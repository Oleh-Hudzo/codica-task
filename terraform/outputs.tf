output "rds_endpoint" {
  value = aws_db_instance.wordpress_rds.endpoint
}

output "ip_for_ssh" {
  value = aws_instance.wordpress.public_ip
}

output "alb_dns" {
  value = aws_lb.wordpress_instance.dns_name
}
