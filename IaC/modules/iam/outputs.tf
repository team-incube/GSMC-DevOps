output "bastion_instance_profile_name" {
  description = "Bastion instance profile name"
  value       = aws_iam_instance_profile.bastion_profile.name
}

output "server_instance_profile_name" {
  description = "Server instance profile name"
  value       = aws_iam_instance_profile.server_profile.name
}

output "db_instance_profile_name" {
  description = "DB instance profile name"
  value       = aws_iam_instance_profile.db_profile.name
}
