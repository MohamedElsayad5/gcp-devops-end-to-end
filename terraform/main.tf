terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# 2. call the VPC module to create the network and subnet
module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
  region     = var.region
  vpc_name   = "gcp-devops-vpc"
}

# 3. call the GKE module to create the cluster and node pools
module "gke" {
  source       = "./modules/gke"
  project_id   = var.project_id
  region       = var.region
  cluster_name = "gcp-devops-gke-cluster"

  # pass the network and subnet information from the VPC module to the GKE module
  network_id   = module.vpc.network_id
  subnet_name  = module.vpc.subnet_name
}