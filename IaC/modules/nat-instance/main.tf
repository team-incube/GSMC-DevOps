# NAT 설정을 위한 임시 인스턴스
resource "aws_instance" "nat_temp" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  source_dest_check      = false

  user_data = <<-EOF
              #!/bin/bash
              echo 1 > /proc/sys/net/ipv4/ip_forward
              iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
              
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              
              # NAT 설정 영구 적용
              echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
              sysctl -p
              
              # iptables 규칙 영구 저장
              apt-get install -y iptables-persistent
              netfilter-persistent save
              EOF

  tags = {
    Name = "${var.prefix}-nat-temp"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# NAT 인스턴스 AMI 생성
resource "aws_ami_from_instance" "nat_ami" {
  name               = "${var.prefix}-nat-ami-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  source_instance_id = aws_instance.nat_temp.id
  snapshot_without_reboot = false

  tags = {
    Name = "${var.prefix}-nat-ami"
  }

  depends_on = [aws_instance.nat_temp]
}

# 실제 NAT 인스턴스 (커스텀 AMI 사용)
resource "aws_instance" "nat_instance" {
  ami                    = aws_ami_from_instance.nat_ami.id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  source_dest_check      = false

  tags = {
    Name = "${var.prefix}-nat-instance"
  }

  depends_on = [aws_ami_from_instance.nat_ami]
}

resource "aws_eip" "nat_eip" {
  instance = aws_instance.nat_instance.id
  domain   = "vpc"

  tags = {
    Name = "${var.prefix}-nat-eip"
  }
}
