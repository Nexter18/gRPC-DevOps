module "networking" {
  source = "./terraform/modules/networking"
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs = var.public_subnet_cidrs
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  availability_zones = var.availability_zones
  
}

module "eks" {
  source = "./terraform/modules/eks"
  aws_region = var.aws_region
  worker_nodes_desired_capacity = var.worker_nodes_desired_capacity
  worker_nodes_max_capacity = var.worker_nodes_max_capacity
  worker_nodes_min_capacity = var.worker_nodes_min_capacity
  cluster_name = var.cluster_name
}
