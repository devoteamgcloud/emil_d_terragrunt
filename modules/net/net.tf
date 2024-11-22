# Sieć w trybie niestandardowym (ręcznym)
resource "google_compute_network" "web" {
  project = var.project_id
  name = var.network_name
  auto_create_subnetworks = false
}

# Podsieć dla strefy, w której będzie grupa instancji
resource "google_compute_subnetwork" "web-subnet" {
  project = var.project_id
  name = var.subnet_name
  ip_cidr_range = var.subnet_ip_cidr_range
  region = var.region
  network = google_compute_network.web.name
}

# Utwórz router Cloud NAT
resource "google_compute_router" "nat_router" {
  project = var.project_id
  name = var.router_name
  region = var.region
  network = google_compute_network.web.id
}

# Utwórz gateway Cloud NAT
resource "google_compute_router_nat" "nat_gateway" {
  project = var.project_id
  name = var.gateway_name
  router = google_compute_router.nat_router.name
  region = var.region
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  nat_ip_allocate_option = "AUTO_ONLY"
}

# Globalny adres IP
resource "google_compute_global_address" "ip_address" {
  project = var.project_id
  address_type = "EXTERNAL"
  name = var.external_ip_name
}