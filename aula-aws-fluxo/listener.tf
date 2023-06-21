resource "aws_lb_listener" "lb_listener_tf" {
  load_balancer_arn = aws_lb.nlb_lb_tf.arn
  port              = local.container_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_tg_tf.arn
  }
}