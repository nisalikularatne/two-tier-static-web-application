# Default tags
variable "default_tags" {
  default = {
    "Owner" = "Group15"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  default     = "Group15"
  type        = string
  description = "Name prefix"
}

# Provision public subnets in custom VPC
variable "public_subnet_cidr_blocks" {
  default     = ["10.250.0.0/24", "10.250.1.0/24", "10.250.2.0/24"]
  type        = list(string)
  description = "Public Subnet CIDRs"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.250.3.0/24", "10.250.4.0/24", "10.250.5.0/24"]
  type        = list(string)
  description = "Private Subnet CIDRs"
}

# VPC CIDR range
variable "vpc_cidr" {
  default     = "10.250.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

# Variable to signal the current environment
variable "env" {
  default     = "prod"
  type        = string
  description = "Deployment Environment"
}
