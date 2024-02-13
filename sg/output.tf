# ALB 보안그룹 Output
output "alb-security" {
  value = aws_security_group.kube-alb.id
}

output "web-security" {
  value = aws_security_group.metabank-web.id
}

output "ssh-security" {
  value = aws_security_group.metabank-ssh.id
}

output "eks-security" {
  value = aws_security_group.eks-cluster-sg.id
}