output "web_sg_id" {
  value = module.security-group-prod.web_sg_id
}

output "load_balancer_id" {
  value = module.security-group-prod.load_balancer_id
}

output "bastion_sg_id" {
  value = module.security-group-prod.bastion_sg_id
}
