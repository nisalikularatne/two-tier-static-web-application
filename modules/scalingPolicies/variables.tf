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
variable "scale_out_threshold" {
  type        = number
  description = "Scale out threshold"
}
variable "scale_in_threshold" {
  type        = number
  description = "Scale in threshold"
}
variable "scale_out_adjustment" {
  type        = number
  description = "Scale out adjustment"
}
variable "scale_in_adjustment" {
  type        = number
  description = "Scale in adjustment"
}
variable "bucket_name" {
  description = "Region for S3 bucket"
  type        = string
}
