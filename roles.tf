data "aws_iam_policy" "eks_cluster_policy" {
  name = "AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_role" {
  name                = var.cluster_role_name
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF
  managed_policy_arns = [data.aws_iam_policy.eks_cluster_policy.id]

  tags = {
    Terraform   = "true"
  }
}


data "aws_iam_policy" "registry_policy" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy" "cni_policy" {
  name = "AmazonEKS_CNI_Policy"
}

data "aws_iam_policy" "node_policy" {
  name = "AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role" "eks_node_role" {
  name                = var.node_role_name
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "ec2.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF
  managed_policy_arns = [data.aws_iam_policy.registry_policy.id, data.aws_iam_policy.cni_policy.id, data.aws_iam_policy.node_policy.id]

  tags = {
    Terraform   = "true"
  }
}
