resource "aws_alb_listener" "bfffargate" {
  load_balancer_arn = aws_alb.alb_bfffargate.arn
  port              = "8081"
  protocol          = "HTTP"
  depends_on        = ["aws_alb_target_group.alb_target_group"]

  default_action {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    type             = "forward"
  }
}
