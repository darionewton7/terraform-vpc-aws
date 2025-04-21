variable "prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "example"
  
}
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "example-cluster"
  
}

variable "retention_in_days" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
  