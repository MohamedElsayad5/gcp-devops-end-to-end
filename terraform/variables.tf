variable "project_id" {
  type        = string
  description = "The GCP Project ID where resources will be created"
}

variable "region" {
  type        = string
  description = "The GCP Region"
  default     = "us-central1"
}