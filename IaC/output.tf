output "vpc_id" {
  description = "VPC ID"
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.network.public_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.network.private_subnet_id
}

output "bastion_public_ip" {
  description = "Bastion host public IP"
  value       = module.bastion.bastion_public_ip
}

output "bastion_key_pair" {
  description = "Bastion key pair name"
  value       = module.bastion.key_pair_name
}

output "nat_instance_id" {
  description = "NAT instance ID"
  value       = module.nat_instance.instance_id
}

output "server_instance_id" {
  description = "Server instance ID"
  value       = module.compute.server_instance_id
}

output "db_instance_id" {
  description = "DB instance ID"
  value       = module.compute.db_instance_id
}
