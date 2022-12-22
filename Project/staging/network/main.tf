# Module to deploy basic networking
module "vpc-staging" {
  source                     = "../../../modules/network"
  env                        = var.env
  vpc_cidr                   = var.vpc_cidr
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  prefix                     = var.prefix
  default_tags               = var.default_tags
}