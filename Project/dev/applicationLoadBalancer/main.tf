module "applicationLoadBalancer-dev" {
  source      = "../../../modules/applicationLoadBalancer"
  prefix      = var.prefix
  bucket_name = var.bucket_name
}
