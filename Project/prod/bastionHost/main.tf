
# Module to deploy basic networking
module "bastion-prod" {
  source        = "../../../modules/bastionHost"
  prefix        = var.prefix
  image         = var.image
  instance_type = var.instance_type
  linux_key_ec2 = var.linux_key_ec2
}