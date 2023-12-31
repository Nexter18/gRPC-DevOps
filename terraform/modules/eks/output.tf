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
