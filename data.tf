data "availbility_zones" "available" {
  count = 3
  name  = var.availbility_zones[count.index]
}
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
