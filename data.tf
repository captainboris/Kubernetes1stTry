# data "aws_availability_zones" "available" {
#   count = 3
#   names  = var.availbility_zones[count.index]
# }
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}
