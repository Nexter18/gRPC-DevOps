resource "aws_ecr_repository" "python_server_repo" {
  name = "python-server-repo"
}

resource "aws_ecr_repository" "python_client_repo" {
  name = "python-client-repo"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = "grpc-sim"
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo nothing"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      asg_desired_capacity          = 2
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo nothing"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]
}

resource "kubernetes_deployment" "python_server" {
  metadata {
    name = "python-app"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "python-server"
      }
    }
    template {
      metadata {
        labels = {
          app = "python-server"
        }
      }
      spec {
        container {
            name = "python-server"
            image = "${aws_ecr_repository.python_server_repo}@${aws_ecr_repository.python_server_repo.image_digest}"
        }
      }
      }
    }
}

resource "kubernetes_deployment" "python_client" {
  metadata {
    name = "python-client"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "python-client"
      }
    }
    template {
      metadata {
        labels = {
          app = "python-client"
        }
      }
      spec {
        container {
            name = "python-client"
            image = "${aws_ecr_repository.python_client_repo}@${aws_ecr_repository.python_client_repo.image_digest}"
        }
      }
      }
    }
}

resource "kubernetes_service" "python_server_service" {
  metadata {
    name = "python-server-service"
  }
  spec {
    selector = {
      app = "python-server"
    }
    port {
      protocol = "TCP"
      port     = 50051
      target_port = 50051
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_service" "python_client_service" {
  metadata {
    name = "python-client-service"
  }
  spec {
    selector = {
      app = "python-client"
    }
    port {
      protocol = "TCP"
      port     = 50051
      target_port = 50051
    }
    type = "LoadBalancer"
  }
}

resource "aws_lb" "app_lb" {
  name               = "python-app-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.private_subnets
}

resource "aws_lb_target_group" "app_target_group" {
  name     = "python-app-tg"
  port     = 50051
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 50051
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body =  "OK"
      status_code  = "200"
    }
  }
}

resource "kubernetes_ingress" "app_ingress" {
  metadata {
    name = "python-app-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "alb"
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
    }
  }
  spec {
    rule {
      http {
        path {
          backend {
            service_name = kubernetes_service.python_server_service.metadata[0].name
            service_port = 50051
          }
        }
      }
    }
  }
}
