output "cluster_endpoint" {
    description = "GKE Control Plane endpoint"
    value = google_container_cluster.primary.endpoint
}

output "artifact_registry_repo" {
    description = "The URI of the Artifact Registry repository"
    value = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.repository_id}"
}

output "google_iam_workload_identity_pool_provider" {
    description = "The state of the workload identity provider"
    value = google_iam_workload_identity_pool_provider.github_provider.name
}