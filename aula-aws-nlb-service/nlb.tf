resource "aws_lb" "nlb" {
  name               = "nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = aws_subnet.public[*].id
}
