# Workload Identity Pool
resource "google_iam_workload_identity_pool" "github_actions" {
    display_name = "Github Actions Pool"
    description = "OIDC pool for GitHub Actions"
    workload_identity_pool_id = "github-actions"
    disabled = false
}

# GitHub Actions Provider
resource "google_iam_workload_identity_pool_provider" "github_provider" {

    display_name = "GitHub Actions Provider"

    workload_identity_pool_id = google_iam_workload_identity_pool.github_actions.workload_identity_pool_id
    workload_identity_pool_provider_id = "github-provider"

    attribute_condition = "assertion.repository_owner == 'Kacper7011'"

    attribute_mapping = {
        "google.subject" = "assertion.sub"
        "attribute.repository" = "assertion.repository"
        "attribute.ref" = "assertion.ref"
        "attribute.actor" = "assertion.actor"
    }

    oidc {
        issuer_uri = "https://token.actions.githubusercontent.com"
    }
}

# Google Service Account
resource "google_service_account" "github_ci" {
    account_id = "github-ci"
    display_name = "GitHub Actions CI"
}

# Give Rigths To Impersonating Account
resource "google_service_account_iam_member" "github_impersonation" {
    service_account_id = google_service_account.github_ci.name
    role = "roles/iam.workloadIdentityUser"
    member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/attribute.repository/Kacper7011/GKE-Autopilot-GitOps-Starter"
}

# Give Ability to create a token
resource "google_service_account_iam_member" "github_token_creator" {
    service_account_id = google_service_account.github_ci.name
    role = "roles/iam.serviceAccountTokenCreator"
    member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/attribute.repository/Kacper7011/GKE-Autopilot-GitOps-Starter"
}

# Allow GitHub to write in Artifact Registry
resource "google_artifact_registry_repository_iam_member" "artifact_registry_writer" {
    project = var.project_id
    repository = google_artifact_registry_repository.repo.name
    role = "roles/artifactregistry.writer"
    member = "serviceAccount:${google_service_account.github_ci.email}"
}

# Add gke_developer to allow to make changes to the k8s-cluster
resource "google_project_iam_member" "gke_developer" {
    project = var.project_id
    role = "roles/container.developer"
    member = "serviceAccount:${google_service_account.github_ci.email}"
}