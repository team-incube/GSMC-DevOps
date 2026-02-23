variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for bastion instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for bastion instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for bastion instance"
  type        = string
}

variable "iam_profile_name" {
  description = "IAM instance profile name"
  type        = string
}
