#--- alb/outputs.tf ----

output "external_loadbalncer" {
  value       = aws_lb.ext-alb.id
  description = "The external loadbalancer"
}

output "internal_loadbancer" {
  value       = aws_lb.int_alb.id
  description = "The intetnal loadbalancer"
}

output "nginx_tg" {
  value       = aws_lb_target_group.nginx-tg.id
  description = "Target group for nginx"
}

output "wordpress_tg" {
  value       = aws_lb_target_group.wordpress-tg.id
  description = "The target group for wordpress"
}

output "tooling_tg" {
  value       = aws_lb_target_group.tooling-tg.id
  description = "The target group for tooling"
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.nginx-tg.arn
}

output "alb_dns_name" {
  value = aws_lb.ext-alb.dns_name
}