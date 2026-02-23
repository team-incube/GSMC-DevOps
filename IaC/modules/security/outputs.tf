output "bastion_sg_id" {
  description = "Bastion security group ID"
  value       = aws_security_group.bastion_sg.id
}

output "nat_instance_sg_id" {
  description = "NAT instance security group ID"
  value       = aws_security_group.nat_instance_sg.id
}

output "server_sg_id" {
  description = "Server security group ID"
  value       = aws_security_group.server_sg.id
}

output "db_sg_id" {
  description = "DB security group ID"
  value       = aws_security_group.db_sg.id
}
