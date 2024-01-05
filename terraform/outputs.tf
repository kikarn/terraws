### Return the DNS record towards the load balancer

output "aws_alb_public_dns" {
  value       = "http://${aws_lb.testburk-lb.dns_name}"
  description = "URL for load balancer"
}
