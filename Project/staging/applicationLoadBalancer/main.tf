module "applicationLoadBalancer-staging" {
  source = "../../../modules/applicationLoadBalancer"
  prefix = var.prefix
}