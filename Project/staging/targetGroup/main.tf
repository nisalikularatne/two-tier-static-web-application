
# Module to deploy basic networking
module "targetGroup-staging" {
  source = "../../../modules/targetGroup"
  env    = var.env
  prefix = var.prefix
}
