# Add output variables
output "web_sg_id" {
  value = aws_security_group.web_sg.id
}
output "load_balancer_id" {
  value = aws_security_group.loadbalancer_sg.id
}
