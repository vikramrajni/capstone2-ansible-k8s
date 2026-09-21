module "eks" {
source  = "terraform-aws-modules/eks/aws"
version = "21.18.0"

name = "myapp-eks-cluster"
kubernetes_version = "1.35"
//cluster_version = "1.35.3"

subnet_ids = module.myapp-vpc.private_subnets
vpc_id = module.myapp-vpc.vpc_id


addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

# Enable public access to the EKS cluster endpoint
endpoint_public_access = true

  # admin permissions for cluster creator
  enable_cluster_creator_admin_permissions = true

# configuration of the worker nodes that are managed instances by EKS
eks_managed_node_groups = {
    dev = {
      kubernetes_version = "1.35"
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

tags = {
    environment = "development"
    application = "myapp"
}
}