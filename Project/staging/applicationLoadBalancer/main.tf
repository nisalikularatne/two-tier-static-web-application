module "applicationLoadBalancer-staging" {
  source      = "../../../modules/applicationLoadBalancer"
  prefix      = var.prefix
  bucket_name = var.bucket_name
  env         = var.env
}