resource "aws_alb" "alb_bfffargate" {
  name            = "${var.environment}-alb-bfffargate"
  subnets         = ["${var.public_subnet_ids}"]
  security_groups = ["${var.security_groups_ids}", "${aws_security_group.web_inbound_sg.id}"]

  tags {
    Name        = "${var.environment}-alb-bfffargate"
    Environment = var.environment
  }
}
