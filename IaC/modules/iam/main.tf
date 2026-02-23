resource "aws_iam_role" "bastion_role" {
  name = "${var.prefix}-bastion-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "${var.prefix}-bastion-role"
  }
}

resource "aws_iam_role_policy_attachment" "bastion_s3_full" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.prefix}-bastion-instance-profile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_iam_role" "server_role" {
  name = "${var.prefix}-server-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "${var.prefix}-server-role"
  }
}

resource "aws_iam_role_policy_attachment" "server_s3_read" {
  role       = aws_iam_role.server_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "server_s3_write" {
  role       = aws_iam_role.server_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "server_ssm" {
  role       = aws_iam_role.server_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_instance_profile" "server_profile" {
  name = "${var.prefix}-server-instance-profile"
  role = aws_iam_role.server_role.name
}

resource "aws_iam_role" "db_role" {
  name = "${var.prefix}-db-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "${var.prefix}-db-role"
  }
}

resource "aws_iam_role_policy_attachment" "db_s3_read" {
  role       = aws_iam_role.db_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "db_s3_write" {
  role       = aws_iam_role.db_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "db_ssm" {
  role       = aws_iam_role.db_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_instance_profile" "db_profile" {
  name = "${var.prefix}-db-instance-profile"
  role = aws_iam_role.db_role.name
}
