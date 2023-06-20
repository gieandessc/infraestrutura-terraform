resource "aws_lb_target_group" "nlb_tg_tf" {
  name        = "tf-lb-nlb-tg"
  target_type = "ip"
  port        = local.container_port
  protocol    = "TCP"
  vpc_id      = aws_vpc.main_tf.id
}