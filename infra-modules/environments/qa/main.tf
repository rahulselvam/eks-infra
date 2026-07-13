terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = var.aws_region
}

module "eks_qa" {
  source = "../../eks-cluster"

  aws_region   = var.aws_region
  environment  = var.environment
  cluster_name = "${var.environment}-eks-cluster"
  vpc_cidr     = var.vpc_cidr

  # Moderate lab configurations: Spot instances, but scaled up for testing loads
  enable_nat_gateway = false
  capacity_type      = "SPOT"
  instance_types     = ["t3.medium"]
  desired_size       = 2
  min_size           = 2
  max_size           = 4
}

output "kubeconfig_cmd" {
  value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks_qa.cluster_name}"
}