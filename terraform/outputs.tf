output "vpc_network_id" {
  value       = module.vpc.network_id
  description = "The ID of the created VPC Network"
}

output "gke_cluster_name" {
  value       = module.gke.cluster_name
  description = "The Name of the GKE Cluster"
}

output "gke_cluster_endpoint" {
  value       = module.gke.kubernetes_cluster_host
  description = "The Endpoint/Host for the GKE Cluster Control Plane"
}