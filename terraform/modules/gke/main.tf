# 1. create the GKE Cluster
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  project  = var.project_id
  location = var.region

  network    = var.network_id
  subnetwork = var.subnet_name

  # allow the cluster to manage its own node pools (we'll create them separately)
  remove_default_node_pool = true
  initial_node_count       = 1

  # determine the IP ranges for Pods and Services using the secondary ranges we created in the VPC module
  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pods"
    services_secondary_range_name = "k8s-services"
  }

  # ensure the cluster uses VPC-native networking
  networking_mode = "VPC_NATIVE"
}

# 2. the first pool: System Node Pool (for management and monitoring tools)
resource "google_container_node_pool" "system_nodes" {
  name       = "system-node-pool"
  project    = var.project_id
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1 # only one node is needed for system tools, as they don't require high availability

  node_config {
    machine_type = "e2-medium" # 
    disk_size_gb = 50

    # the magic label we'll use in Kubernetes Node Affinity
    labels = {
      role = "system"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# 3. the second pool: Application Node Pool (for running the Web and API services)
resource "google_container_node_pool" "app_nodes" {
  name       = "app-node-pool"
  project    = var.project_id
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 2 # 2 servers for the Web and API services, to ensure high availability

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 50

    # the magic label we'll use in Kubernetes Node Affinity
    labels = {
      role = "application"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}