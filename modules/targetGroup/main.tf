# Use remote state to retrieve the data
data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "${var.env}-acs730-finalproject-group15" // Bucket from where to GET Terraform State
    key    = "${var.env}-network/terraform.tfstate"   // Object name in the bucket to GET Terraform State
    region = "us-east-1"                              // Region where bucket created
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

resource "aws_lb_target_group" "this" {
  name     = "${local.name_prefix}-alb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-alb-target-group"
    }
  )
}
