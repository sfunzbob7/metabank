#create EKS Cluster eks_cluster

resource "aws_eks_cluster" "eks_cluster" {
  name = var.PROJECT_NAME

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController
  ]

  # The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations
  role_arn = aws_iam_role.eks_cluster_role.arn

  # Desired Kubernetes master version
  version = "1.27"

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false
    subnet_ids = [
      data.terraform_remote_state.metabank-eks.outputs.PRI_SUB3_ID,
      data.terraform_remote_state.metabank-eks.outputs.PRI_SUB4_ID
    ]
    security_group_ids = [data.terraform_remote_state.metabank-sg.outputs.eks-security]
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "eks-cluster-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role.name
}
