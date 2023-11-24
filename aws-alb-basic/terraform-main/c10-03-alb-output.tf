# Terraform AWS Application Load Balancer (ALB) Outputs
output "this_lb_id" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.alb.id
}

output "this_lb_arn" {
  description = "The ID and ARN of the load balancer we created."
  value       = module.alb.arn
}

output "this_lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.alb.dns_name
}

output "this_lb_arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch."
  value       = module.alb.arn_suffix
}

output "this_lb_zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records."
  value       = module.alb.zone_id
}

output "this_lb_listeners" {
  description = "The IDs of the TCP and HTTP load balancer listeners created."
  value       = module.alb.listeners
}

output "this_lb_target_group" {
  description = "The target groups. Useful for passing to your Auto Scaling group."
  value       = module.alb.target_groups
}
