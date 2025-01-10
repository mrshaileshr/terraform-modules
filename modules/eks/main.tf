module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"

  cluster_name    = "jenkins-eks-cluster"
  cluster_version = "1.21"
  subnet_ids      = var.private_subnets
  vpc_id          = var.vpc_id
}

module "eks_managed_node_group" {
  source  = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "20.31.6"

  cluster_name    = module.eks.cluster_id
  node_group_iam_instance_profile_name = module.eks.node_group_iam_instance_profile_name

  subnet_ids            = var.private_subnets
  instance_type         = "t3.medium"
  desired_capacity      = 2
  min_size              = 1
  max_size              = 3
}
