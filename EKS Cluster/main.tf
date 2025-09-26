#VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "Kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  private_subnet_tags = {
    "Kubernetes.io/cluster/my-eks-cluster" = "shared"
    "Kubernetes.io/role/internal-elb"      = "1"
  }

  public_subnet_tags = {
    "Kubernetes.io/cluster/my-eks-cluster" = "shared"
    "Kubernetes.io/role/elb"               = "1"
  }
}

#EKS Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-eks-cluster"
  kubernetes_version = "1.27"


  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.small"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}