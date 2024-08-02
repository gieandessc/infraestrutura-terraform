module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 1.6.0"

  repository_force_delete = true
  repository_name         = local.example
  repository_lifecycle_policy = jsonencode({
    rules = [{
      action = {
        type = "expire"
      }
      description  = "Delete all images except a handful of the newest images"
      rulePriority = 1
      selection = {
        countNumber = 3
        countType   = "imageCountMoreThan"
        tagStatus   = "any"
      }
    }]
  })
}
