locals {
  cluster_name = "voting-app-cluster"
}
module "eks" {
    source = "terraform-aws-modules/eks/aws"
#   param  = value
    version = "20.8.3"
    cluster_name = "${local.cluster_name}"
    cluster_version = "1.28"
    subnet_ids = module.vpc.private_subnets
    vpc_id = module.vpc.vpc_id
    eks_managed_node_groups = {
        first = {
            desired_capcity = 1
            max_capacity = 2
            min_capacity = 1
            instance_type = "m5.large"
        }
    }
}

module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "5.6.0"
    name = "my-vpc"
    cidr = "10.0.0.0/16"

    azs             = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

    enable_nat_gateway = true
    enable_vpn_gateway = true
    enable_dns_hostnames = true
    public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }  

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

module "eks-config" {
  source = "./kube-config-module"
  depends_on = [module.eks]
  cluster_name =  "${local.cluster_name}"
}

resource local_file "kubeconfig" {
  content = module.eks-config.kubeconfig
  filename = "kubeconfig_${local.cluster_name}"
}
#eip quota