resource "aws_codebuild_project" "python_app_build" {
  name = "python-app-build"
  description = "Build and deploy Python application to EKS"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:5.0"
    type = "LINUX_CONTAINER"

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "us-east-2"
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = "account-id"
    }

    environment_variable {
      name  = "ECR_REPO_URI"
      value = aws_ecr_repository.python_app_repo.repository_url
    }
  }

  source {
    type            = "NO_SOURCE"
    buildspec = "buildspec.yml"

    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "master"
  build_timeout = "5"
  
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-python-app-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "codebuild_policy" {
  name = "codebuild_policy"
  description = "Policy for codebuild"
  path = "/"
  policy = templatefile("${path.module}/policy/policy.json", {})
}

resource "aws_iam_policy_attachment" "codebuild_policy_attachment" {
  name = "codebuild-python-app-attachment"
  roles = [aws_iam_role.codebuild_role.name]
  policy_arn = aws_iam_policy.codebuild_policy.arn
}
