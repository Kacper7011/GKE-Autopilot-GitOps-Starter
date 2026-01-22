variable "project_id" {
  description = "gke-autopilot-gitops-starter"
  type = string
}

variable "region" {
    description = "Resource region"
    type = string
    default = "europe-west1"
}

variable "cluster_name" {
    description = "k8s-cluster"
    type = string
    default = "k8s-cluster"
}