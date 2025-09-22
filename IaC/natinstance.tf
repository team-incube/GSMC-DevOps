resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnets[0]
  key_name = aws_key_pair.bastion-key-pair.key_name 

  vpc_security_group_ids = [
    aws_security_group.nat-instance-sg.id
  ]

  tags = {
    "Name" = "${var.prefix}-bastion"
  }

  depends_on = [ module.vpc ]
}