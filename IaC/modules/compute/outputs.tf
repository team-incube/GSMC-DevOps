output "server_instance_id" {
  description = "Server instance ID"
  value       = aws_instance.server.id
}

output "db_instance_id" {
  description = "DB instance ID"
  value       = aws_instance.db.id
}
