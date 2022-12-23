# Add output variables
output "web_sg_id" {
  value = aws_security_group.webSg.id
}
output "load_balancer_id" {
  value = aws_security_group.loadbalancerSg.id
}
output "bastion_sg_id" {
  value = aws_security_group.bastionSg.id
}
