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
  default = 1
}
variable "max_size" {
  type    = number
  default = 4
}
variable "min_size" {
  type    = number
  default = 1
}

# Variable to signal the current environment
variable "env" {
  default     = "prod"
  type        = string
  description = "Deployment Environment"
}



