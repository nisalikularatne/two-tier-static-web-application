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
data "terraform_remote_state" "targetGroup" {
  backend = "s3"
  config = {
    bucket = var.bucket_name                            // Bucket from where to GET Terraform State
    key    = "${var.env}-targetGroup/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                // Region where bucket created
  }
}
data "terraform_remote_state" "autoScalingGroup" {
  backend = "s3"
  config = {
    bucket = var.bucket_name                                    // Bucket from where to GET Terraform State
    key    = "${var.env}-autoScalingGroupEC2/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                                        // Region where bucket created
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

#Create scale out policy
resource "aws_autoscaling_policy" "scaleOutPolicy" {
  name                   = "${local.name_prefix}-scalingpolicy10percent"
  autoscaling_group_name = data.terraform_remote_state.autoScalingGroup.outputs.auto_scaling_group_name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scale_out_adjustment
  cooldown               = 60

}

#Creating an alarm metric when combined CPU usage of all the instances  reaches or greater  10%
resource "aws_cloudwatch_metric_alarm" "scaleOutPolicyMetric" {
  alarm_description   = "CPU usage of all the instances surpasses 10%"
  alarm_actions       = [aws_autoscaling_policy.scaleOutPolicy.arn]
  alarm_name          = "${local.name_prefix}-scaleOutPolicyMetric10%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = var.scale_out_threshold
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = data.terraform_remote_state.autoScalingGroup.outputs.auto_scaling_group_name
  }
  tags = {
    Name = "${local.name_prefix}-scaleOutPolicyMetric10"
  }
}


#Creating Scaling in autoscaling policy
resource "aws_autoscaling_policy" "scaleInPolicy" {
  name                   = "${local.name_prefix}-scalingpolicy5percent"
  autoscaling_group_name = data.terraform_remote_state.autoScalingGroup.outputs.auto_scaling_group_name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = var.scale_in_adjustment
  cooldown               = 60
}
#Creating an alarm metric when combined CPU usage of all the instances  less then  or equal 5%
resource "aws_cloudwatch_metric_alarm" "scaleInPolicyMetric" {
  alarm_description   = "CPU usage of all the instances  less then  or equal 5%"
  alarm_actions       = [aws_autoscaling_policy.scaleInPolicy.arn]
  alarm_name          = "${local.name_prefix}-scaleInPolicyMetric5%"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = var.scale_in_threshold
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = data.terraform_remote_state.autoScalingGroup.outputs.auto_scaling_group_name
  }
}

