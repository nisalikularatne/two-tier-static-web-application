
# Module to deploy basic networking
module "security-group-prod" {
  source         = "../../../modules/securityGroup"
  env            = var.env
  from_port_http = 80
  from_port_ssh  = 22
  to_port_http   = 80
  to_port_ssh    = 22
  prefix         = var.prefix
  bucket_name    = var.bucket_name
}
