# Application Load Balancer
resource "aws_lb" "alb" {
  name               = "wp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [aws_subnet.sn_public_a.id , aws_subnet.sn_public_b.id]

  tags = {
    Name = "${var.default_tag}-alb"
  }
}

# Target group
resource "aws_lb_target_group" "webserver" {
  name        = "wp-instance-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.wp-vpc.id
  target_type = "ip"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver.arn
  }
}

resource "aws_lb_listener_rule" "rule1" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

resource "aws_lb_target_group_attachment" "attachment" {
  depends_on       = [aws_instance.wp-instance]
  target_group_arn = aws_lb_target_group.webserver.arn
  target_id        = aws_instance.wp-instance.private_ip
  port             = 80
}
