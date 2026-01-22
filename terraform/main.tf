#1. Enabling Compute, Container, Cloud Build, Artifact Registry API's
provider "google" {
    credentials = file("")
    project = "gke-autopilot-gitops-starter"
    region = "europe-west1"
}

resource "google_project_service" "compute" {
    project = "gke-autopilot-gitops-starter"
    service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
    service = "container.googleapis.com"
}

resource "google_project_service" "artifact_registry" {
    service = "artifactregistry.googleapis.com"
}

#2. Configuration for VPC network

resource "google_compute_network" "vpc" {
    name = "gke-vpc"
    auto_create_subnetworks = "true"
    depends_on = [ google_project_service.compute ]
}

#3. Artifact registry for docker images
resource "google_artifact_registry_repository" "repo" {
    location = "europe-west1"
    repository_id = "app-repo"
    description = "Docker repository for my app"
    format = "DOCKER"

    depends_on = [ google_project_service.artifact_registry ]
}

#4. GKE Autopilot Cluster
resource "google_container_cluster" "primary" {
    name = "k8s-cluster"
    location = "europe-west1"

    enable_autopilot = true
    network = google_compute_network.vpc.name

    ip_allocation_policy {
      cluster_ipv4_cidr_block = ""
      services_ipv4_cidr_block = ""
    }

    depends_on = [ google_project_service.container ]
}
