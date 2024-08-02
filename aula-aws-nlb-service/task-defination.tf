resource "aws_ecs_task_definition" "task_definition_tf" {
  family                   = "family-of-${local.example}-tasks"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.ecs_tasks_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_tasks_role.arn
  container_definitions = jsonencode([
    {
      name      = local.container_name,
      image     = docker_registry_image.this.name,
      cpu       = 10,
      memory    = 512,
      essential = true,
      portMappings = [
        {
          containerPort = local.container_port,
          hostPort      = local.container_port
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name,
          "awslogs-region"        = data.aws_region.this.name,
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
  depends_on = [aws_cloudwatch_log_group.ecs_log_group]
}
