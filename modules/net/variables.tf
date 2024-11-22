variable "project_id" {
  description = "The project id where app will be deployed"
  type = string
  default = "emil-d-demo"
  
}

variable "region" {
  description = "The region where app will be deployed"
  type = string
  default = "europe-west1"
  
}

variable "zone" {
  description = "The zone where app will be deployed"
  type = string
  default = "europe-west1-b"
  
}


variable "network_name" {
  description = "Name of the network"
  type = string
  default = "web"
  
}

variable "subnet_name" {
  description = "Name of the subnet"
  type = string
  default = "web-subnet"
  
}

variable "subnet_ip_cidr_range" {
  description = "IP CIDR range for the subnet"
  type = string
  default = "10.128.0.0/20"
  
}

variable "router_name" {
  description = "Name of the Cloud NAT router"
  type = string
  default = "nat-router"
  
}

variable "gateway_name" {
  description = "Name of the Cloud NAT gateway"
  type = string
  default = "nat-gateway"
  
}

variable "external_ip_name" {
  description = "Name of the external IP address"
  type = string
  default = "external-ip"
  
}

