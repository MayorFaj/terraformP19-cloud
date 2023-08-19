#--- alb/lb.tf

#create external application load balancer
resource "aws_lb" "ext-alb" {
  name            = "pbl-ext-alb"
  internal        = false
  security_groups = [var.public_sg]

  subnets = [
    var.pub_subnet_1,
    var.pub_subnet_2
  ]

  tags = merge(
    var.tags,
    {
      Name = "pbl-ext-alb"
    },
  )

  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
}

#create target groups to inform external alb where to route traffic to
resource "aws_lb_target_group" "nginx-tg" {
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = var.protocol
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "nginx-tg"
  port        = var.port
  protocol    = var.protocol
  target_type = "instance"
  vpc_id      = var.vpc_id
  lifecycle {
    ignore_changes        = [name]
    create_before_destroy = true
  }
}

#--create listener group for this target group

resource "aws_lb_listener" "nginx-listner" {
  load_balancer_arn = aws_lb.ext-alb.arn
  port              = var.port
  protocol          = var.protocol
  certificate_arn   = aws_acm_certificate_validation.mayorfaj.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tg.arn
  }
}


#create internal application load balancer
resource "aws_lb" "int_alb" {
  name               = "pbl-int-alb"
  internal           = true
  ip_address_type    = var.ip_address_type
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.private_sg]

  subnets = [
    var.priv_subnet_1,
    var.priv_subnet_2
  ]
  tags = merge(
    var.tags,
    {
      Name = "pbl-int-alb"
    }
  )
}

#create target group to inform internal alb wher to direct traffic
#target group for wordpress---
resource "aws_lb_target_group" "wordpress-tg" {
  name        = "wordpress-tg"
  port        = var.port
  protocol    = var.protocol
  target_type = "instance"
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = var.protocol
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

#target group for tooling ----
resource "aws_lb_target_group" "tooling-tg" {
  name        = "tooling-tg"
  port        = var.port
  protocol    = var.protocol
  target_type = "instance"
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    interval            = 10
    path                = "/healthstatus"
    protocol            = var.protocol
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}


#create a listener for the target
#For this aspect a single listener was created for the wordpress which is default,
# A rule was created to route traffic to tooling when the host header changes

resource "aws_lb_listener" "webserver-listener" {
  load_balancer_arn = aws_lb.int_alb.arn
  port              = var.port
  protocol          = var.protocol
  certificate_arn   = aws_acm_certificate_validation.mayorfaj.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tg.arn
  }
}

#--listener rule for tooling target

resource "aws_lb_listener_rule" "tooling-listener" {
  listener_arn = aws_lb_listener.webserver-listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tooling-tg.arn
  }

  condition {
    host_header {
      values = ["tooling.mayorfaj.io"]
    }
  }
}