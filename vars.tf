# general
variable "project_id" {
  type        = string
  description = "GCP project name"
}

variable "region" {
  type        = string
  description = "GCP region"
}

# gcs
variable "bucket_name" {
  type        = string
  description = "The name of the Google Storage Bucket"
}

variable "storage_class" {
  type        = string
  description = "The storage class of the Google Storage Bucket"
}

# network
variable "network_name" {
  type        = string
  description = "The name of the VPC network"
}

variable "subnetwork_name" {
  type        = string
  description = "The name of the subnetwork"
}

variable "ip_range_pods_name" {
  type        = string
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services_name" {
  type        = string
  description = "The secondary ip range to use for services"
}

# gke
variable "cluster_name" {
  type        = string
  description = "The name of the Google Kubernetes Engine cluster"
}

variable "node_pool_name" {
  type        = string
  description = "The name of the Google Kubernetes Engine cluster node pool"
}

variable "node_machine_type" {
  type        = string
  description = "The name of a Google Compute Engine machine type"
}

variable "zones" {
  type        = list(string)
  description = "Google Kubernetes Engine zones"
}

# airflow
variable "airflow_username" {
  type        = string
  description = "Airflow username"
}

variable "airflow_password" {
  type        = string
  description = "Airflow password"
}
