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