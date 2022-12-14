# Use remote state to retrieve the data
data "terraform_remote_state" "network" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "${var.env}-acs730-finalproject-group15" // Bucket from where to GET Terraform State
    key    = "${var.env}-network/terraform.tfstate"   // Object name in the bucket to GET Terraform State
    region = "us-east-1"                              // Region where bucket created
  }
}
data "terraform_remote_state" "security_group" { // This is to use Outputs from Remote State
  backend = "s3"
  config = {
    bucket = "${var.env}-acs730-finalproject-group15"      // Bucket from where to GET Terraform State
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
#Create application load balancer
resource "aws_alb" "this" {
  name            = "${local.name_prefix}-alb"
  security_groups = [data.terraform_remote_state.security_group.outputs.load_balancer_id]
  subnets         = data.terraform_remote_state.network.outputs.public_subnet_ids[*]
  tags = {
    Name = "${local.name_prefix}-alb"
  }
}
