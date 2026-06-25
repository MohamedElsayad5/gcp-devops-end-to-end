variable "project_id" {
  type        = string
  description = "Google Cloud Project ID"
}

variable "region" {
  type        = string
  description = "GCP Region to deploy resources"
  default     = "us-central1"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC Network"
  default     = "gcp-devops-vpc"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR range for the GKE subnet"
  default     = "10.0.1.0/24"
}