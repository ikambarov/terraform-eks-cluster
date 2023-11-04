variable "cluster_role_name" {
  type        = string
  default     = "eksClusterRole"
}

variable "node_role_name" {
  type        = string
  default     = "eksNodeRole"
}

variable "cluster_name" {
  type        = string
  default     = "cluster1"
}

variable "cluster_version" {
  type        = string
  default     = "1.28"
}
