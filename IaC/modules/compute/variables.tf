variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for instances"
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "server_sg_id" {
  description = "Server security group ID"
  type        = string
}

variable "db_sg_id" {
  description = "DB security group ID"
  type        = string
}

variable "server_instance_profile" {
  description = "Server IAM instance profile name"
  type        = string
}

variable "db_instance_profile" {
  description = "DB IAM instance profile name"
  type        = string
}
