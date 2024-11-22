# Reguła zapory - HTTPS
# Konto serwisowe
resource "google_service_account" "nginx_sa" {
  account_id   = var.sa_name
  project      = var.project_id
  display_name = var.sa_display_name
}

# Lokalny email konta serwisowego
locals {
  sa_email = google_service_account.nginx_sa.email
}

resource "google_compute_firewall" "default-allow-https" {
  project = var.project_id
  name    = var.firewall_https_name
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_service_accounts = [local.sa_email]
  source_ranges           = ["0.0.0.0/0"]
}

# Reguła zapory - SSH
resource "google_compute_firewall" "default-allow-ssh" {
  project = var.project_id
  name    = var.firewall_ssh_name
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_service_accounts = [local.sa_email]
  source_ranges           = ["0.0.0.0/0"]
}

# Szablon instancji
resource "google_compute_instance_template" "nginx_template" {
  project      = var.project_id
  name_prefix  = var.instance_template_name_prefix
  machine_type = var.machine_type
  disk {
    source_image = var.source_image
    boot         = true
  }

  network_interface {
    subnetwork = var.subnetwork_name
  }

  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y nginx google-cloud-sdk
      
      # Skopiuj stronę internetową z bucket'a
      gsutil -m cp -r gs://${var.www_bucket}/www/* /var/www/html/

      # Skopiuj plik konfiguracyjny Nginx
      gsutil cp gs://${var.nginx_conf} /etc/nginx/sites-available/default

      # Włącz nową konfigurację Nginx
      ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
      
      # Restart Nginx
      systemctl restart nginx
    EOF
  }

  service_account {
    email  = local.sa_email
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only"]
  }
}

# Menedżer grupy instancji
resource "google_compute_instance_group_manager" "instance_group_manager" {
  project = var.project_id
  name    = var.instance_group_manager_name
  version {
    name              = "primary"
    instance_template = google_compute_instance_template.nginx_template.id
  }

  base_instance_name = "nginx-instance"
  zone               = var.zone
  target_size        = var.target_size
}