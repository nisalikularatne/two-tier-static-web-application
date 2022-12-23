provider "aws" {
  region = "us-east-1"
}
# Use remote state to retrieve the data
data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = var.bucket_name                        // Bucket from where to GET Terraform State
    key    = "${var.env}-network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                            // Region where bucket created
  }
}
data "terraform_remote_state" "securityGroup" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = var.bucket_name                               // Bucket from where to GET Terraform State
    key    = "${var.env}-security-group/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                   // Region where bucket created
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
# Set the path to the directory with the objects you want to add to the bucket
resource "aws_s3_object" "this" {
  for_each = fileset("${path.module}/images", "*")

  bucket = var.bucket_name
  key    = "images/${each.key}"
  source = "${path.module}/images/${each.key}"
}
# Data source for AMI id
data "aws_ami" "latestAmazonLinux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_launch_template" "this" {
  name          = "${local.name_prefix}-aws_launch_template"
  image_id      = data.aws_ami.latestAmazonLinux.id
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
  depends_on             = [aws_s3_object.this]
  vpc_security_group_ids = [data.terraform_remote_state.securityGroup.outputs.web_sg_id]
  user_data              = base64encode(templatefile("${path.module}/install_httpd.sh.tpl", { env = var.env }))
}
