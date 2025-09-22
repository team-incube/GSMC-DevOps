data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu 공식 소유자 ID)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "installing-docker" {
  template = <<EOF
#!/bin/bash
sudo yum update -y 
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo newgrp docker
EOF
}

data "template_file" "installing-nginx" {
  template = <<EOF
#!/bin/bash
sudo yum update -y 
sudo yum install -y nginx
sudo systemctl start nginx
EOF
}