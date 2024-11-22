variable "project_id" {
  description = "The project id where app will be deployed"
  type        = string
  default     = "emil-d-demo"

}

variable "region" {
  description = "The region where app will be deployed"
  type        = string
  default     = "europe-west1"

}

variable "zone" {
  description = "The zone where app will be deployed"
  type        = string
  default     = "europe-west1-b"

}

variable "www_bucket" {
  description = "The website template"
  type        = string
  default     = "gcd2024_emil_d_demo"

}

variable "nginx_conf" {
  description = "nginx config file"
  type        = string
  default     = "gcd2024_emil_d_demo/nginx.conf"

}

variable "sa_name" {
  description = "Service account name"
  type        = string
  default     = "nginx-sa"

}

variable "sa_display_name" {
  description = "Display name for the service account"
  type        = string
  default     = "Service account for Nginx instances"

}

variable "firewall_https_name" {
  description = "Name of the HTTPS firewall rule"
  type        = string
  default     = "default-allow-https"

}

variable "firewall_ssh_name" {
  description = "Name of the SSH firewall rule"
  type        = string
  default     = "default-allow-ssh-web"

}

variable "instance_template_name_prefix" {
  description = "Name prefix for the instance template"
  type        = string
  default     = "nginx-template-"

}

variable "machine_type" {
  description = "Machine type for the instances"
  type        = string
  default     = "n1-standard-1"

}

variable "source_image" {
  description = "Source image for the instances"
  type        = string
  default     = "debian-cloud/debian-11"

}

variable "instance_group_manager_name" {
  description = "Name of the instance group manager"
  type        = string
  default     = "nginx-group-manager"

}

variable "target_size" {
  description = "Target size for the instance group"
  type        = number
  default     = 3

}

variable "network_name" {
  description = "The name of the network"
  type        = string
  default     = "web"

}

variable "subnetwork_name" {
  description = "The name of the subnetwork"
  type        = string
  default     = "web"
}