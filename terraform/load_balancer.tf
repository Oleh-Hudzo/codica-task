resource "aws_lb" "alb" {
  name               = "wp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_web.id]
  subnets            = [aws_subnet.sn_public_a.id , aws_subnet.sn_public_b.id]
}

resource "aws_lb_target_group" "target_group" {
  name        = "wp-instance-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.wp-vpc.id
  target_type = "ip"
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "attachment" {
  depends_on = [aws_instance.wp-instance]
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.wp-instance.private_ip
  port             = 80
}
