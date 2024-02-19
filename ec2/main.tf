resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  key_name      = "metabank-key"
  vpc_security_group_ids = [
    data.terraform_remote_state.metabank-ec2-sg.outputs.ssh-security
  ]
  subnet_id                   = data.terraform_remote_state.metabank-ec2-vpc.outputs.PUB_SUB1_ID
  associate_public_ip_address = true

  tags = {
    Name = "metabank-bastion-instance"
  }
}

# Jenkins Instance 생성
resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.medium"
  key_name      = "metabank-key"
  vpc_security_group_ids = [
    data.terraform_remote_state.metabank-ec2-sg.outputs.web-security,
    data.terraform_remote_state.metabank-ec2-sg.outputs.ssh-security
  ]
  subnet_id                   = data.terraform_remote_state.metabank-ec2-vpc.outputs.PRI_SUB4_ID
  associate_public_ip_address = false

  tags = {
    Name = "metabank-jenkins-instance"
  }
}