# GKE-Autopilot-GitOps-Starter

This project demonstrates a production-ready CI/CD workflow and infrastructure deployment on Google Cloud Platform (GCP) using a **GitOps** approach. It leverages **GKE Autopilot** for cost optimization and security, with **Terraform** managing the entire resource lifecycle.

## 🚀 Project Status: Phase 1 (Infrastructure)
Currently, the project focuses on automating the cloud foundations using Infrastructure as Code (IaC).

### Tech Stack
* **Cloud Provider:** Google Cloud Platform (GCP)
* **IaC:** Terraform
* **Orchestration:** Kubernetes (GKE Autopilot)
* **Container Registry:** Artifact Registry

---

## 🛠️ Infrastructure Architecture
The Terraform configuration in the `/terraform` directory manages:
* **VPC Network:** A dedicated network for the GKE cluster to ensure isolation.
* **GKE Autopilot:** A fully managed Kubernetes cluster that handles node provisioning and scaling automatically.
* **Artifact Registry:** A private Docker repository to store application images.
* **Service APIs:** Automated enablement of required GCP services (Compute, Container, Artifact Registry).



---

## 🏁 Getting Started

### Prerequisites
1. **GCP Project:** An active Google Cloud project with billing enabled.
2. **GCP CLI:** Installed and authenticated locally (`gcloud auth application-default login`).
3. **Terraform:** Version 1.0+ installed on your machine.

### Deployment
1. Navigate to the terraform directory:
   ```bash
   cd terraform
