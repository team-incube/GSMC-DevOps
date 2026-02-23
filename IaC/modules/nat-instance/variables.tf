variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for NAT instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for NAT instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for NAT instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}
