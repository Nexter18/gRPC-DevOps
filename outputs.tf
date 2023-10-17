output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.my_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = aws_subnet.private_subnet[*].id
}

output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint."
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "eks_cluster_vpc_id" {
  description = "ID of the VPC where the EKS cluster is deployed."
  value       = module.vpc.vpc_id
}
