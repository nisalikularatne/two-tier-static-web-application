#Output variables for staging environment
output "public_subnet_ids" {
  value = module.vpc-staging.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc-staging.private_subnet_ids
}
output "natgateway_ids" {
  value = module.vpc-staging.nat_gateway_id
}
output "vpc_id" {
  value = module.vpc-staging.vpc_id
}
