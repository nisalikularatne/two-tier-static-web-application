provider "aws" {
  region = "us-east-1"
}
# Use remote state to retrieve the data
data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = var.bucketName                        // Bucket from where to GET Terraform State
    key    = "${var.env}-network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                            // Region where bucket created
  }
}
data "terraform_remote_state" "security_group" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = var.bucketName                               // Bucket from where to GET Terraform State
    key    = "${var.env}-security-group/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                   // Region where bucket created
  }
}
data "terraform_remote_state" "targetGroup" {
  backend = "s3"
  config = {
    bucket = var.bucketName                            // Bucket from where to GET Terraform State
    key    = "${var.env}-targetGroup/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                // Region where bucket created
  }
}
# Local variables
locals {
  defaultTags = merge(
    var.defaultTags,
    { "Env" = var.env }
  )
  name_prefix = "${var.prefix}-${var.env}"
}
#Create application load balancer
resource "aws_alb" "this" {
  name            = "${local.name_prefix}-alb"
  security_groups = [data.terraform_remote_state.security_group.outputs.load_balancer_id]
  subnets         = data.terraform_remote_state.network.outputs.public_subnet_ids[*]
  tags = {
    Name = "${local.name_prefix}-alb"
  }
}
# Creating load balance listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = data.terraform_remote_state.targetGroup.outputs.target_group_arn
  }
}
