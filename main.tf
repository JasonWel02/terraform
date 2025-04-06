terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc6"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}
provider "google" {
  project = "jasons-test-env"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }







resource "google_cloud_run_v2_service" "simple-cloud-run" {
  client              = "cloud-console"
  ingress             = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  deletion_protection = false
  launch_stage        = "GA"
  location            = "us-central1"
  name                = "test-cloud-run"
  project             = "jasons-test-env"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      ports {
        container_port = 8080
        # name           = "http1"
      }
      resources {
        cpu_idle = true

        limits = {
          cpu    = "2"
          memory = "2Gi"
        }

      }

    }
    service_account = ""
  }
}
# data "google_iam_policy" "admin" {
#   binding {
#     role = "roles/run.invoker"
#     members = [
#       "allUsers",
#     ]
#   }
# }

# resource "google_cloud_run_v2_service_iam_policy" "policy" {
#   project = google_cloud_run_v2_service.simple-cloud-run.project
#   location = google_cloud_run_v2_service.simple-cloud-run.location
#   name = google_cloud_run_v2_service.simple-cloud-run.name
#   policy_data = data.google_iam_policy.admin.policy_data
# }
# # provider "docker"{}

# resource "docker_image" "nginx"{
#     name = "nginx"
#     keep_locally = false
# }
# resource "docker_container" "nginx" {
#     image = docker_image.nginx.image_id
#     name = "tutorial"

#     ports {
#         internal = 80
#         external = 8000
#     }
# }
# provider "proxmox" {
  # pm_api_url          = "https://192.168.1.185:8006/api2/json"
  # pm_api_token_id     = "root@pam!terraform-automation"
  # pm_api_token_secret = "e541c9ce-dcde-4e1d-b8e0-add63a8d1d54"
  # pm_tls_insecure     = true
# }
# 
# resource "proxmox_vm_qemu" "debian1" {
  # name        = "debian2"
  # target_node = "pve"
  # clone       = "debian"
  # full_clone  = true
  # boot        = "order=scsi0"
  # cores       = 2
  # sockets     = 1
  # memory      = 2048
  # disks {
    # scsi {
      # scsi0 {
        # disk {
          # size    = "15G"
          # storage = "local-lvm"
          # discard = true
        # }
      # }
    # }
  # }
  # network {
    # id       = 0
    # model    = "virtio"
    # bridge   = "vmbr0"
    # firewall = false
  # }
# }