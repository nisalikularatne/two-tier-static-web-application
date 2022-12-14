# Default tags
variable "default_tags" {
  default = {
    "Owner" = "Prajesh"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  default     = "Project-Group15"
  type        = string
  description = "Name prefix"
}

# Provision public subnets in custom VPC
variable "private_cidr_blocks" {
  default     = ["10.250.0.0/24", "10.250.1.0/24"]
  type        = list(string)
  description = "Public Subnet CIDRs"
}

# VPC CIDR range
variable "vpc_cidr" {
  default     = "10.250.0.0/16"
  type        = string
  description = "VPC to host static web site"
}

