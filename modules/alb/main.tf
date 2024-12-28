# Create Target Group
resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"  # Đặt target type là "ip" để phù hợp với network mode "awsvpc"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "Doan-target-group"
    Type = "Target group for ALB"
    Author = var.author
  }
}

# Create Application Load Balancer
resource "aws_lb" "application_load_balancer" {
  name               = var.alb_name
  internal           = false               # False nếu bạn muốn ALB có thể truy cập từ internet
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids      # Danh sách các subnet để ALB có thể phân phối lưu lượng

  enable_deletion_protection = false       # Đặt thành true nếu bạn muốn bảo vệ ALB khỏi việc bị xóa nhầm

  tags = {
    Name   = "Doan-application-lb"
    Type   = "Application Load Balancer"
    Author = var.author
  }
}
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
