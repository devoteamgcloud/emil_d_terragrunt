output "network_name" {
  value = google_compute_network.web.id
}

output "subnet_name" {
  value = google_compute_subnetwork.web_subnet.id
}

output "router_name" {
  value = google_compute_router.nat_router.id
}

output "gateway_name" {
  value = google_compute_router_nat.nat_gateway.id
}

# output "external_ip_name" {
#   value = google_compute_global_address.ip_address.id
# } 