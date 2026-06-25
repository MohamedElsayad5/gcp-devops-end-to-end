output "network_id" {
  value       = google_compute_network.vpc.id
  description = "The ID of the VPC network"
}

output "subnet_id" {
  value       = google_compute_subnetwork.gke_subnet.id
  description = "The ID of the GKE subnet"
}

output "subnet_name" {
  value       = google_compute_subnetwork.gke_subnet.name
  description = "The Name of the GKE subnet"
}