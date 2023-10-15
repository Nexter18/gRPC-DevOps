# gRPC-DevOps

This project is a demonstration of creating gRPC-based Python applications and provisioning infrastructure using Terraform. It includes two main components: gRPC applications and Terraform modules for networking and Amazon Elastic Kubernetes Service (EKS) deployment.

## Table of Contents
Project Structure
gRPC Applications
gRPC Service and Messages
Server Application
Client Application
Terraform Modules
MODULO 1 (Networking)
MODULO 2 (EKS)
Main Terraform Configuration
Usage
Documentation
Notes

## Project Structure


> project-root/
> │
> ├── grpc/
> │   ├── your_service.proto
> │   ├── server.py
> │   └── client.py
> │
> ├── networking/
> │   └── main.tf
> │
> ├── eks/
> │   └── main.tf
> │
> ├── main.tf
> ├── README.md


## gRPC Applications

### gRPC Service and Messages
The your_service.proto file defines the gRPC service and message types.

### Server Application
The server.py file implements the gRPC server.
The server responds to client requests with a greeting message.

### Client Application
The client.py file implements the gRPC client.
The client sends a request to the server and receives a response.

## Terraform Modules

MODULE 1 (Networking)
The networking directory contains a Terraform module for networking infrastructure.
It includes the creation of a Virtual Private Cloud (VPC), subnets, and other necessary networking resources.

MODULO 2 (EKS)
The eks directory contains a Terraform module for deploying the application in Amazon EKS.
It provisions an EKS cluster, worker nodes, an Application Load Balancer, and sets up CI/CD using AWS CodeBuild.

## Main Terraform Configuration
The main.tf file in the project root combines the two Terraform modules.

## Usage
Clone this repository to your local machine.
Set up AWS credentials for Terraform.
Navigate to the project root directory.
Run terraform init to initialize Terraform.
Run terraform apply to provision the infrastructure.

## Documentation
Detailed documentation, architecture diagrams, and deployment guides can be found in the project documentation folder.
It is advisable to customize the documentation based on your specific project details.

## Notes
Ensure that state is stored remotely in an S3 bucket for Terraform to maintain state consistency.
Modify configuration files and resource settings as per your project requirements.
For more in-depth instructions and customizations, please refer to the relevant documentation, official AWS, gRPC, and Terraform documentation, and make adjustments as needed.
