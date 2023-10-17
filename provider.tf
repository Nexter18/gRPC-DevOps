terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }    
  }

  backend "s3" {
    bucket = "terraform-state-sim"
    key = "state/gRPC/grpc.tfstatefile"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "my-context"
}