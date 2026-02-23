resource "aws_instance" "server" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  iam_instance_profile   = var.server_instance_profile
  vpc_security_group_ids = [var.server_sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "${var.prefix}-server"
  }
}

resource "aws_instance" "db" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  subnet_id              = var.private_subnet_id
  key_name               = var.key_name
  iam_instance_profile   = var.db_instance_profile
  vpc_security_group_ids = [var.db_sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "${var.prefix}-db"
  }
}
