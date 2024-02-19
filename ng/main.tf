# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

resource "aws_eks_node_group" "eks_node" {
  # Name of the EKS Cluster
  cluster_name = data.terraform_remote_state.metabank-node-eks.outputs.EKS_CLUSTER_NAME

  # Name of the EKS Node Group.
  node_group_name = "${data.terraform_remote_state.metabank-node-eks.outputs.EKS_CLUSTER_NAME}-node-group"

  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = aws_iam_role.eks-node-role.arn

  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/EKS_CLUSTER_NAME 

  subnet_ids = [
    data.terraform_remote_state.metabank-node-vpc.outputs.PRI_SUB3_ID,
    data.terraform_remote_state.metabank-node-vpc.outputs.PRI_SUB4_ID
  ]

  # Configuration block
  scaling_config {
    # Required number of worker nodes
    desired_size = 2

    # Maximum number of worker nodes
    max_size = 5

    # Minimum number of worker nodes
    min_size = 2
  }

  update_config {
    max_unavailable = 1
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group

  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group

  capacity_type = "ON_DEMAND"

  # Disk size in GB for worker nodes
  disk_size = 40

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly
  ]

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue
  force_update_version = false

  # Instance type associated with the EKS Node Group
  instance_types = ["t2.large"]

  # Kubernetes version
  version = "1.27"
}

resource "aws_iam_role" "eks-node-role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSWorkerNodePolicy" {

  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKS_CNI_Policy" {

  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-role.name
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEC2ContainerRegistryReadOnly" {

  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-role.name
}