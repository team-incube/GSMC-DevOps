output "instance_id" {
  description = "NAT instance ID"
  value       = aws_instance.nat_instance.id
}

output "public_ip" {
  description = "NAT instance public IP"
  value       = aws_eip.nat_eip.public_ip
}
