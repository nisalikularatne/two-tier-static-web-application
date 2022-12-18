# Staging Config File
terraform {
  backend "s3" {
    key    = "staging-network/terraform.tfstate"   // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                           // Region where bucket is created
  }
}