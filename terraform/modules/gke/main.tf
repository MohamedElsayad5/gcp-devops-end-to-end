
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  project  = var.project_id
  location = "${var.region}-a" # us-central1-a
  deletion_protection = false

  network    = var.network_id
  subnetwork = var.subnet_name

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pods"
    services_secondary_range_name = "k8s-services"
  }

  networking_mode = "VPC_NATIVE"
}

resource "google_container_node_pool" "system_nodes" {
  name    = "system-node-pool"
  project = var.project_id
  
  location = google_container_cluster.primary.location
  cluster  = google_container_cluster.primary.name
  
  node_count = 1

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 30
    labels       = { role = "system" }
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_container_node_pool" "app_nodes" {
  name    = "app-node-pool"
  project = var.project_id
  
  location = google_container_cluster.primary.location
  cluster  = google_container_cluster.primary.name
  
  node_count = 1 

  node_config {
    machine_type = "e2-small"
    disk_size_gb = 30
    labels       = { role = "application" }
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}