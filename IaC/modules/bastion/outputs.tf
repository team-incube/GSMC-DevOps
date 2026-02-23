output "bastion_instance_id" {
  description = "Bastion instance ID"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Bastion public IP"
  value       = aws_eip.bastion_eip.public_ip
}

output "key_pair_name" {
  description = "Key pair name"
  value       = aws_key_pair.bastion_key_pair.key_name
}
