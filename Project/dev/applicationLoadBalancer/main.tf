module "applicationLoadBalancer-dev" {
  source = "../../../modules/applicationLoadBalancer"
  prefix = var.prefix
}
