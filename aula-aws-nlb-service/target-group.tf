resource "aws_lb_target_group" "ecs_tg" {
  name        = "ecs-tg"
  port        = local.container_port
  protocol    = "TCP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"
}
