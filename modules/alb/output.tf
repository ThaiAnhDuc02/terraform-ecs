output "target_group_id" {
  value = aws_lb_target_group.target_group.id
}

# Output cho Application Load Balancer ARN
output "alb_arn" {
  value = aws_lb.application_load_balancer.arn
  description = "The ARN of the Application Load Balancer"
}

# Output cho Application Load Balancer DNS Name
output "alb_dns_name" {
  value = aws_lb.application_load_balancer.dns_name
  description = "The DNS name of the Application Load Balancer"
}

# Output cho Listener ARN
output "listener_arn" {
  value = aws_lb_listener.http_listener.arn
  description = "The ARN of the HTTP listener for the ALB"
}