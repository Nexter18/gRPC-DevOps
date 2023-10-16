variable "aws_region" {
  description = "AWS region where the EKS cluster will be deployed."
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
}

variable "eks_subnets" {
  description = "List of subnets where EKS will be deployed."
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will be deployed."
}

variable "worker_nodes_desired_capacity" {
  description = "Desired number of worker nodes."
  type        = number
}

variable "worker_nodes_max_capacity" {
  description = "Maximum number of worker nodes."
  type        = number
}

variable "worker_nodes_min_capacity" {
  description = "Minimum number of worker nodes."
  type        = number
}

variable "python_app_image" {
  description = "Docker image URL for the Python app."
}
