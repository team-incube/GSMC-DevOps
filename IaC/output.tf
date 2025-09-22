
###############
#  key pair  #
###############

output "aws_key_pair" {
  description = "key pair"
  value = aws_key_pair.bastion-key-pair.key_name
  
}

###############
#    vpc id   # 
###############

output "vpc_id" {
  description = "VPC_ID"
  value = module.vpc.vpc_id
}

###############
# subnet ids  #
###############

output "public_subnet_id" {
  description = "public subnet id"
  value = module.vpc.public_subnets[0]
  
}

output "private_subnet_id" {
  description = "private subnet id"
  value = module.vpc.private_subnets[0]
  
}

################
#install docker#
################

output "installing-docker" {
    description = "installing docker script"
    value = data.template_file.installing-docker.rendered
}

###############
#   ami id    # 
###############

output "aws_ami_id" {
  description = "AWS AMI ID"
  value = data.aws_ami.ubuntu.id
  
}

###############
#    sg id    #
###############

output "bastion_sg_id" {
  description = "bastion security group id"
  value = aws_security_group.bastion-sg.id
  
}

output "db_sg_id" {
  description = "db instance security group id"
  value = aws_security_group.db-sg.id
  
}

output "natinstance_sg_id" {
  description = "nat instance security group id"
  value = aws_security_group.nat-instance-sg.id
  
}

output "server_sg_id" {
  description = "server security group id"
  value = aws_security_group.server-sg.id
  
}

