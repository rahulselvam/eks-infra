terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region
}

module "eks_prod" {
  source = "/Users/rahul/Documents/learning/eks-cluster/eks-infra/infra-modules/eks-cluster"

  aws_region   = var.aws_region
  environment  = var.environment
  cluster_name = "${var.environment}-eks-cluster"
  vpc_cidr     = var.vpc_cidr

  # Production-grade: True Private isolated routing with NAT Gateways and On-Demand instances
  enable_nat_gateway = true
  capacity_type      = "ON_DEMAND"
  instance_types     = ["m5.large"]
  desired_size       = 3
  min_size           = 3
  max_size           = 10
}

output "kubeconfig_cmd" {
  value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks_prod.cluster_name}"
}