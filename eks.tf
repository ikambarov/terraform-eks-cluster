data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "all_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

resource "aws_eks_cluster" "eks_cluster" {
 name = var.cluster_name
 version = var.cluster_version
 role_arn = aws_iam_role.eks_role.arn

 vpc_config {
  subnet_ids = data.aws_subnets.all_subnets.ids
 }

 depends_on = [aws_iam_role.eks_role]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name  = var.cluster_name
  node_group_name = "group1"
  version         = aws_eks_cluster.eks_cluster.version
  node_role_arn  = aws_iam_role.eks_node_role.arn
  subnet_ids   = data.aws_subnets.all_subnets.ids
  instance_types = ["t3.medium"]
 
  scaling_config {
   desired_size = 2
   max_size   = 2
   min_size   = 2
  }
  
  depends_on = [aws_iam_role.eks_node_role, aws_eks_cluster.eks_cluster]
 }

