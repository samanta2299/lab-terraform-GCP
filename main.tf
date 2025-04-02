provider "google" {
  project     = "terraform-gcp-my-project1"
  region      = "europe-west8"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  zone         = "europe-west8-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

output "vm_ip" {
  description = "The public IP address of the VM instance"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
