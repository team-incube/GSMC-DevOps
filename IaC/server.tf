resource "aws_iam_role" "server_instance_profile" {
  name = "asg_instance_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attachment_s3-ReadOnly" {
  role = aws_iam_role.server_instance_profile.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

}

resource "aws_iam_role_policy_attachment" "attachment_s3-Write" {
  role = aws_iam_role.server_instance_profile.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3WriteOnlyAccess"
  
}

resource "aws_iam_role_policy_attachment" "attachment_ssm" {
    role = aws_iam_role.server_instance_profile.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  
}

resource "aws_iam_role_policy_attachement" "server_instance_profile" {
  role = aws_iam_role.server_instance_profile.name
  name = "${var.prefix}-db-instance-profile"
  
}

resource "aws_instance" "db_instance" {
  ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    subnet_id = module.vpc.private_subnets[0]
    key_name = aws_key_pair.bastion-key-pair.key_name
    iam_instance_profile = aws_iam_role.server_instance_profile.name


    vpc_security_group_ids = [
      aws_security_group.server-sg.id
    ]
    tags = {
      "Name" = "${var.prefix}-db-instance"
    }
    depends_on = [ module.vpc ]
}