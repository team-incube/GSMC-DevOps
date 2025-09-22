################################
#         bastion sg           #
################################

resource "aws_security_group" "bastion-sg" {
  name = "${var.prefix}-bastion-sg"
    description = "Security group for bastion host"
    vpc_id = module.vpc.vpc_id

    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH from anywhere"
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
        description = "Allow all outbound traffic"
    }
    depends_on = [ module.vpc ]


}

################################
#           db sg              #
################################

resource "aws_security_group" "db-sg" {
  name        = "${var.prefix}-db-sg"
  description = "Security group for db instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [
      aws_security_group.nat-instance-sg.id,
      aws_security_group.server-sg.id
    ]
    description = "Allow MySQL access from NAT instance and server"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
    depends_on = [ module.vpc ]
}

################################
#         natinstance sg       #
################################

resource "aws_security_group" "nat-instance-sg" {
  name        = "${var.prefix}-nat-instance-sg"
  description = "Security group for NAT instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow HTTP from anywhere"
}

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "Allow HTTPS from anywhere"
    }

    egress {  
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
        description = "Allow all outbound traffic"
        }
    depends_on = [ module.vpc ]
}

################################
#         server sg            #
################################

resource "aws_security_group" "server-sg" {
  name        = "${var.prefix}-server-sg"
  description = "Security group for server instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [ 
        aws_security_group.nat-instance-sg.id,
        aws_security_group.bastion-sg.id
     ]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [ 
        aws_security_group.nat-instance-sg.id,
        aws_security_group.bastion-sg.id
     ]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [ 
        aws_security_group.bastion-sg.id
     ]
    description = "Allow SSH from bastion host"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Allow all outbound traffic"
  
}
    depends_on = [ module.vpc ]
}