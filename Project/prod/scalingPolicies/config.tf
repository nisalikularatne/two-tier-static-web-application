terraform {
  backend "s3" {
    bucket = "prod-acs730-finalproject-group15-ashish"       // Bucket where to SAVE Terraform State
    key    = "prod-scalingPolicies/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                              // Region where bucket is created
  }
}
