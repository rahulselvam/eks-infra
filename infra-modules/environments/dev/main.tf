terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region
}

module "eks_dev" {
  source = "./infra-modules/eks-cluster"

  aws_region   = var.aws_region
  environment  = var.environment
  cluster_name = "${var.environment}-eks-cluster1"
  vpc_cidr     = var.vpc_cidr

  # Budget configuration: Public networks, Spot strategy, small constraints
  enable_nat_gateway = true
  capacity_type      = "SPOT"
  instance_types     = ["t3.small"]
  desired_size       = 1
  min_size           = 1
  max_size           = 2
}

output "kubeconfig_cmd" {
  value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks_dev.cluster_name}"
}