resource "aws_ecs_service" "ecs_service" {
  name                               = "${local.example}-service"
  cluster                            = aws_ecs_cluster.main.id
  task_definition                    = aws_ecs_task_definition.task_definition_tf.arn
  launch_type                        = "FARGATE"
  desired_count                      = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  scheduling_strategy                = "REPLICA"

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = local.container_name
    container_port   = local.container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = aws_subnet.public[*].id
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [desired_count] # Allow external changes to happen without Terraform conflicts, particularly around auto-scaling.
  }
}
