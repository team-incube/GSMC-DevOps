variable "prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "gsmc"
  
}

variable "region" {
  description = "region for resource creation"
  type        = string
  default     = "ap-northeast-2"
  
}

variable "awscli_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"
  
}