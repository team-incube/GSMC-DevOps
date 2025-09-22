## bastion eip
resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion.id
  domain = "vpc"
}

## bastion key pair
resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits = 2048
  
}

resource "aws_key_pair" "bastion-key-pair" {
  key_name = "${var.prefix}-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

resource "local_file" "bastion_private_key" {
  content = tls_private_key.bastion_key.private_key_pem
  filename = "${path.module}/gwangsan-key.pem"
}

## bastion role
resource "aws_iam_role" "gsmc-bastion_role" {
  name = "${var.prefix}-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role_attachment" {
  role = aws_iam_role.gsmc-bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.prefix}-instance-profile"
  role = aws_iam_role.gsmc-bastion_role.name
}  

resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnets[0]
  key_name = aws_key_pair.bastion-key-pair.key_name 
  iam_instance_profile = aws_iam_instance_profile.bastion_profile.id

  vpc_security_group_ids = [
    aws_security_group.bastion-sg.id
  ]

  tags = {
    "Name" = "${var.prefix}-bastion"
  }

  depends_on = [ module.vpc ]
}