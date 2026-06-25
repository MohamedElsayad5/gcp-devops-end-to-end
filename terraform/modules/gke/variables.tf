variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "region" {
  type        = string
  description = "GCP Region"
}

variable "network_id" {
  type        = string
  description = "The ID of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "The Name of the GKE subnet"
}

variable "cluster_name" {
  type        = string
  default     = "gcp-devops-gke-cluster"
}