output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.vpc.public_subnets[0]
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.vpc.private_subnets[0]
}
