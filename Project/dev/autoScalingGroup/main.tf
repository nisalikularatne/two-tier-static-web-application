module "autoScalingGroup-dev" {
  source = "../../../modules/autoScalingGroup"
  prefix = var.prefix

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size
  bucket_name      = var.bucket_name
}
