resource "aws_lb" "elb-terraform" {
  name               = var.name
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.lb_sg]
  subnets            = [var.lb_subnet,var.lb_subnet2]

  enable_deletion_protection = false	

  }
resource "aws_lb_target_group" "terraform-target_group" {
  name     = "terraformtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.lb_vpc
}
resource "aws_lb_target_group_attachment" "target_terraform" {
  target_group_arn = aws_lb_target_group.terraform-target_group.arn
  target_id        = var.lb_instance
  port             = 80
}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.elb-terraform.arn
  port              = "443"
  protocol          = "HTTPS"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
   ssl_policy        =  "ELBSecurityPolicy-FS-1-2-Res-2020-10"
  certificate_arn   = var.acm_certificate

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform-target_group.arn
  }
}
resource "aws_lb_listener" "front_end2" {
  load_balancer_arn = aws_lb.elb-terraform.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }


}


