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


# Variable to signal the current environment
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}
variable "scale_out_threshold" {
  default     = 10
  type        = number
  description = "Scale out threshold"
}
variable "scale_in_threshold" {
  default     = 5
  type        = number
  description = "Scale in threshold"
}
variable "scale_in_adjustment" {
  default     = -1
  type        = number
  description = "Scale in adjustment"
}
variable "scale_out_adjustment" {
  default     = 1
  type        = number
  description = "Scale out adjustment"
}
