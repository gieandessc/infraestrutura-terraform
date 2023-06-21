resource "aws_lb" "nlb_lb_tf" {
  name               = "nlb-lb-tf"
  internal           = true
  load_balancer_type = "network"
  subnets            = [aws_subnet.main_subnet_1_tf.id, aws_subnet.main_subnet_2_tf.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_api_gateway_vpc_link" "gtw_vpc_link_tf" {
  name        = "gtw-vpc-link-tf"
  description = "example description"
  target_arns = [aws_lb.nlb_lb_tf.arn]
}