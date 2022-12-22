
# Module to deploy basic networking
module "launchTemplate-dev" {
  source        = "../../../modules/launchTemplate"
  prefix        = var.prefix
  instance_type = var.instance_type
  linux_key_ec2 = var.linux_key_ec2
  bucket_name   = var.bucket_name
  env           = var.env
}
