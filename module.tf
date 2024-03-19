module "eks" {
    source = "./modules eks"
#   param  = value
    version = "20.8.3"
    cluter_name = "${local.cluster_name}"
    cluster_version = "1.28"
    subnet_ids = module.vpc.private_subnets
    vpc_id = module.vpc.vpc_id
    eks_managed_node-groups = {
        first = {
            desired_capcity = 1
            max_capacity = 3
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

    azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

    enable_nat_gateway = true
    enable_vpn_gateway = true

    tags = {
        Terraform = "true"
        Environment = "dev"
  }
}