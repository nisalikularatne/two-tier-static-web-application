output "public_subnet_ids" {
  value = module.vpc-dev.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc-dev.private_subnet_ids
}
output "natgateway_ids" {
  value = module.vpc-dev.nat_gateway_id
}
output "vpc_id" {
  value = module.vpc-dev.vpc_id
}
