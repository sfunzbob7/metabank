# ALB Secure 생성
resource "aws_security_group" "kube-alb" {
  name        = "kube ALB Accept"
  description = "for ALB Accept"
  vpc_id      = data.terraform_remote_state.metabank-nat.outputs.VPC_ID

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kube ALB Accept"
  }
}

# SSH Security group 생성
resource "aws_security_group" "metabank-ssh" {
  name        = "matabank SSH Accept"
  description = "for SSH Accept"
  vpc_id      = data.terraform_remote_state.metabank-nat.outputs.VPC_ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "metabank SSH Accept"
  }
}

# WEB Security group 생성성
resource "aws_security_group" "metabank-web" {
  name        = "metabank WEB Accept"
  description = "for Web Accept"
  vpc_id      = data.terraform_remote_state.metabank-nat.outputs.VPC_ID

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "metabank WEB Accept"
  }
}

# eks-sg 생성
resource "aws_security_group" "eks-cluster-sg" {
  name        = "eks-cluster-sg"
  description = "security-group for eks-cluster"
  vpc_id      = data.terraform_remote_state.metabank-nat.outputs.VPC_ID

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}