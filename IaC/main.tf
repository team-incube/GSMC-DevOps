data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "network" {
  source = "./modules/network"
  
  prefix = var.prefix
  region = var.region
}

module "security" {
  source = "./modules/security"
  
  prefix = var.prefix
  vpc_id = module.network.vpc_id
}

module "iam" {
  source = "./modules/iam"
  
  prefix = var.prefix
}

module "bastion" {
  source = "./modules/bastion"
  
  prefix            = var.prefix
  ami_id            = data.aws_ami.ubuntu.id
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security.bastion_sg_id
  iam_profile_name  = module.iam.bastion_instance_profile_name
}

module "nat_instance" {
  source = "./modules/nat-instance"
  
  prefix            = var.prefix
  ami_id            = data.aws_ami.ubuntu.id
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security.nat_instance_sg_id
  key_name          = module.bastion.key_pair_name
}

module "compute" {
  source = "./modules/compute"
  
  prefix                    = var.prefix
  ami_id                    = data.aws_ami.ubuntu.id
  private_subnet_id         = module.network.private_subnet_id
  key_name                  = module.bastion.key_pair_name
  server_sg_id              = module.security.server_sg_id
  db_sg_id                  = module.security.db_sg_id
  server_instance_profile   = module.iam.server_instance_profile_name
  db_instance_profile       = module.iam.db_instance_profile_name
}
