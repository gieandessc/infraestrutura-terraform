/*====
ECS task definitions
======*/

/* the task definition for the web service */
data "template_file" "web_task" {
  template = file("${path.module}/tasks/web_task_definition.json")

  vars {
    image     = aws_ecr_repository.bffgarfate_app.repository_url
    log_group = aws_cloudwatch_log_group.bffgarfate.name
  }
}

resource "aws_ecs_task_definition" "web" {
  family                   = "${var.environment}_web"
  container_definitions    = data.template_file.web_task.rendered
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn
}
