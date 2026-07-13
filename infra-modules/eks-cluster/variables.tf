variable "aws_region" {
  type        = string
  description = "AWS deployment region"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "environment" {
  type        = string
  description = "Environment identifier (dev, qa, prod)"
}

variable "vpc_cidr" {
  type        = string
  description = "Base CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Toggle true for standard architecture (NAT + Private subnets), false for cost-saving (Public subnets only)"
  default     = false
}

variable "capacity_type" {
  type        = string
  description = "Node allocation strategy: SPOT or ON_DEMAND"
  default     = "SPOT"
}

variable "instance_types" {
  type        = list(string)
  description = "EC2 instance types for the worker nodes"
  default     = ["t3.small"]
}

variable "desired_size" {
  type        = number
  description = "Initial target number of worker nodes"
}

variable "min_size" {
  type        = number
  description = "Minimum bounds for Auto Scaling"
}

variable "max_size" {
  type        = number
  description = "Maximum bounds for Auto Scaling"
}