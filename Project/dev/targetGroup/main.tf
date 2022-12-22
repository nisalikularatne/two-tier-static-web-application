
# Module to deploy basic networking
module "targetGroup-dev" {
  source      = "../../../modules/targetGroup"
  env         = var.env
  prefix      = var.prefix
  bucket_name = var.bucket_name
}
