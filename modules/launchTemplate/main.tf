# Use remote state to retrieve the data
data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "${var.env}-acs730-nisalikularatnebucket-group15" // Bucket from where to GET Terraform State
    key    = "${var.env}-network/terraform.tfstate"            // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                       // Region where bucket created
  }
}
data "terraform_remote_state" "security_group" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "${var.env}-acs730-nisalikularatnebucket-group15" // Bucket from where to GET Terraform State
    key    = "${var.env}-security-group/terraform.tfstate"     // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                       // Region where bucket created
  }
}

# Local variables
locals {
  default_tags = merge(
    var.default_tags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}
resource "aws_s3_bucket" "webserver" {
  bucket = "group15-finalproject-nisalikularatne-webserver"

}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.webserver.id
  acl    = "private"
}
# Set the path to the directory with the objects you want to add to the bucket
resource "aws_s3_object" "example" {
  for_each = fileset("${path.module}/images", "*")

  bucket = aws_s3_bucket.webserver.id
  key    = "images/${each.key}"
  source = "${path.module}/images/${each.key}"
}
resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.webserver.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_launch_template" "this" {
  name          = "${local.name_prefix}-aws_launch_template"
  image_id      = var.image
  instance_type = var.instance_type

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  instance_initiated_shutdown_behavior = "terminate"
  monitoring {
    enabled = true
  }
  key_name = var.linux_key_ec2
  iam_instance_profile {
    name = "LabInstanceProfile"
  }
  depends_on             = [aws_s3_object.example]
  vpc_security_group_ids = [data.terraform_remote_state.security_group.outputs.web_sg_id]
  user_data              = filebase64("${path.module}/install_httpd.sh")
}
