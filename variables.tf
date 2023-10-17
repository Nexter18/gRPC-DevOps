variable "aws_region" {
  description = "AWS region where the EKS cluster will be deployed."
  default = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  default = "my-eks-cluster"
}

variable "worker_nodes_desired_capacity" {
  description = "Desired number of worker nodes."
  type        = number
  default = 2
}

variable "worker_nodes_max_capacity" {
  description = "Maximum number of worker nodes."
  type        = number
  default = 4
}

variable "worker_nodes_min_capacity" {
  description = "Minimum number of worker nodes."
  type        = number
  default = 1
}

variable "vpc_name" {
  description = "Name for the VPC."
  type        = string
  default = "python-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones for subnets."
  type        = list(string)
  default = ["us-east-2a", "us-east-2b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets."
  type        = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}
