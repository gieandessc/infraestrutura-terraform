# data "aws_iam_role" "ecs_task_execution_role" { name = "AmazonECSTaskExecutionRole" }

resource "aws_ecs_task_definition" "task_definition_tf" {
  family                   = "family-of-${local.example}-tasks"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  # task_role_arn            = "${aws_iam_role.github-role.arn}"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      name      = local.container_name,
      image     = resource.docker_registry_image.this.name,
      cpu       = 10,
      memory    = 512,
      essential = true,
      portMappings = [
        {
          containerPort = local.container_port
          hostPort      = local.container_port
        }
      ]
    }
  ])
}