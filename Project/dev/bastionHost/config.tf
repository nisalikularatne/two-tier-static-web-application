terraform {
  backend "s3" {
    bucket = "dev-acs730-nisalikularatnebucket-group15" // Bucket where to SAVE Terraform State
    key    = "dev-bastion-host/terraform.tfstate"       // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"                                // Region where bucket is created
  }
}
