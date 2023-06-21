resource "aws_ecs_service" "ecs_service_tf" {
  name            = "${local.example}-service"
  cluster         = module.ecs.cluster_id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_definition_tf.arn
  desired_count   = 3

  load_balancer {
    container_name   = local.container_name
    container_port   = local.container_port
    target_group_arn = aws_lb_target_group.nlb_tg_tf.arn
  }

  lifecycle {
    ignore_changes = [desired_count] # Allow external changes to happen without Terraform conflicts, particularly around auto-scaling.
  }

  network_configuration {
    security_groups = [aws_vpc.main_tf.default_security_group_id]
    subnets         = [aws_subnet.main_subnet_1_tf.id, aws_subnet.main_subnet_2_tf.id]
  }
}