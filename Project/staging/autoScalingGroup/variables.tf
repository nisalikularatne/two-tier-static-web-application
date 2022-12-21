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

variable "desired_capacity" {
  type    = number
  default = 3
}
variable "max_size" {
  type    = number
  default = 4
}
variable "min_size" {
  type    = number
  default = 3
}

# Variable to signal the current environment
variable "env" {
  default     = "staging"
  type        = string
  description = "Deployment Environment"
}
variable "bucket_name" {
  description = "Region for S3 bucket"
  type        = string
  default     = "staging-acs730-finalproject-group15-bucket"
}



