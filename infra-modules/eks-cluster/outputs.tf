output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "vpc_id" {
  value = aws_vpc.this.id
}