# Default tags
variable "default_tags" {
  default = {
    "Owner" = "Group15",
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

# Name prefix
variable "prefix" {
  type        = string
  default     = "Group15"
  description = "Name prefix"
}

variable "image" {
  type        = string
  default     = "ami-0b0dcb5067f052a63"
  description = "Instance Type for the Launch Template"
}

variable "instance_type" {
  default     = "t3.medium"
  type        = string
  description = "The type of the instance to be deployed"
}

variable "linux_key_ec2" {
  default     = "acs-project-prod"
  description = "Path to the public key to use in Linux VMs provisioning"
  type        = string
}

variable "s3_role_name" {
  default     = "s3-access-profile"
  description = "Path to the public key to use in Linux VMs provisioning"
  type        = string
}
variable "region" {
  default     = "us-east-1"
  description = "Region for S3 bucket"
  type        = string
}
variable "bucket_name" {
  default     = "prod-acs730-finalproject-group15-bucket"
  description = "Region for S3 bucket"
  type        = string
}

# Variable to signal the current environment
variable "env" {
  default     = "prod"
  type        = string
  description = "Deployment Environment"
}