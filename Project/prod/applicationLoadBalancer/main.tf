module "applicationLoadBalancer-prod" {
  source      = "../../../modules/applicationLoadBalancer"
  prefix      = var.prefix
  env         = var.env
  bucket_name = var.bucket_name
}