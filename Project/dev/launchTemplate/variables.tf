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
  default     = "t3.micro"
  type        = string
  description = "The type of the instance to be deployed"
}

variable "linux_key_ec2" {
  default     = "acs-project"
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
  default     = "dev-acs730-finalproject-group15-bucket"
  description = "Region for S3 bucket"
  type        = string
}

variable "env" {
  default     = "dev"
  description = "Description for deployment environment"
  type        = string
}
