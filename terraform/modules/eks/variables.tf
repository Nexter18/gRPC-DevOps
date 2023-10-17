variable "aws_region" {
  description = "AWS region where the EKS cluster will be deployed."
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
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
