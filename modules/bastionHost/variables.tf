# Default tags
variable "default_tags" {
  default     = {}
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}
# Variable to signal the current environment
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}
# Name prefix
variable "prefix" {
  type        = string
  description = "Name prefix"
}

variable "instance_type" {
  type        = string
  description = "Instance Type for the Launch Template"
}
variable "linux_key_ec2" {
  description = "Path to the public key for linux VM provisioning"
  type        = string
}
variable "bucket_name" {
  description = "Region for S3 bucket"
  type        = string
}
