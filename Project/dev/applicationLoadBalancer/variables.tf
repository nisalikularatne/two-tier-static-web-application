# Default tags
variable "default_tags" {
  default = {
    "Owner" = "Group15",
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}
variable "bucket_name" {
  default     = "dev-acs730-finalproject-group15-bucket"
  description = "Region for S3 bucket"
  type        = string
}
# Name prefix
variable "prefix" {
  type        = string
  default     = "Group15"
  description = "Name prefix"
}





