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

data "terraform_remote_state" "launchTemplate" {
  backend = "s3"
  config = {
    bucket = "${var.env}-acs730-finalproject-group15"      // Bucket from where to GET Terraform State
    key    = "${var.env}-launchTemplate/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                   // Region where bucket created
  }
}
data "terraform_remote_state" "targetGroup" {
  backend = "s3"
  config = {
    bucket = "${var.env}-acs730-finalproject-group15"   // Bucket from where to GET Terraform State
    key    = "${var.env}-targetGroup/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                // Region where bucket created
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

resource "aws_autoscaling_group" "this" {
  name             = "${local.name_prefix}-asg"
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  launch_template {
    id      = data.terraform_remote_state.launchTemplate.outputs.launch_template_id
    version = "$Latest"
  }
  target_group_arns = [data.terraform_remote_state.targetGroup.outputs.target_group_arn]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier = data.terraform_remote_state.network.outputs.private_subnet_ids[*]
  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-asg"
    propagate_at_launch = true
  }
}
