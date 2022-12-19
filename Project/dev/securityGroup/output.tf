output "web_sg_id" {
  value = module.security-group-dev.web_sg_id
}

output "load_balancer_id" {
  value = module.security-group-dev.load_balancer_id
}

output "bastion_sg_id" {
  value = module.security-group-dev.bastion_sg_id
}
