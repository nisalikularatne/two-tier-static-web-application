
# Module to deploy basic networking
module "scalingPolicies-prod" {
  source               = "../../../modules/scalingPolicies"
  env                  = var.env
  prefix               = var.prefix
  scale_out_threshold  = var.scale_out_threshold
  scale_in_threshold   = var.scale_in_threshold
  scale_in_adjustment  = var.scale_in_adjustment
  scale_out_adjustment = var.scale_out_adjustment
  bucket_name          = var.bucket_name
}
