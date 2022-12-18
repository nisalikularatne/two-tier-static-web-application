
# Module to deploy basic networking
module "launchTemplate-prod" {
  source        = "../../../modules/launchTemplate"
  prefix        = var.prefix
  image         = var.image
  instance_type = var.instance_type
  linux_key_ec2 = var.linux_key_ec2
}
