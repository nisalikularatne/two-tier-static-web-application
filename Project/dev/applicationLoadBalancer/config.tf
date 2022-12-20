terraform {
  backend "s3" {
    bucket = "dev-acs730-finalproject-group15-bucket" // Bucket where to SAVE Terraform State
    key    = "dev-loadBalancer/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                          // Region where bucket is created
  }
}
