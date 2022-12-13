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

variable "from_port_http" {
  type        = number
  description = "Port from HTTP"
}

variable "to_port_http" {
  type        = number
  description = "Port to HTTP"
}
variable "from_port_ssh" {
  type        = number
  description = "Port from SSH"
}

variable "to_port_ssh" {
  type        = number
  description = "Port to SSH"
}
