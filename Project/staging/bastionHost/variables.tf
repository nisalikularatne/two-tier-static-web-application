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

variable "instance_type" {
  default     = "t3.small"
  type        = string
  description = "The type of the instance to be deployed"
}

variable "linux_key_ec2" {
  default     = "acs-project-staging"
  description = "Path to the public key to use in Linux VMs provisioning"
  type        = string
}

# Variable to signal the current environment
variable "env" {
  default     = "staging"
  type        = string
  description = "Deployment Environment"
}
variable "bucket_name" {
  default     = "staging-acs730-finalproject-group15-bucket"
  description = "Region for S3 bucket"
  type        = string
}
