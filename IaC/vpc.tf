module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.prefix}-vpc"
  cidr = "192.168.0.0/16"

  azs = ["${var.region}a"]
  public_subnets = ["192.168.10.0/24"]
  private_subnets = ["192.168.11.0/24"]

  map_public_ip_on_launch = true

  public_subnet_tags = {
    "Name" = "${var.prefix}-publicsubnet"
  }
  private_subnet_tags = {
    "Name" = "${var.prefix}-privatesubnet"
  }
}