module "sa" {
  source      = "terraform-google-modules/service-accounts/google"
  version     = "4.1.1"
  project_id  = var.project_id
  description = "The service account to run nodes"
  prefix      = "gke-sa"
  names       = ["nodes"]
  project_roles = [
    "${var.project_id}=>roles/compute.viewer",
    "${var.project_id}=>roles/container.clusterAdmin",
    "${var.project_id}=>roles/container.developer",
    "${var.project_id}=>roles/iam.serviceAccountAdmin",
    "${var.project_id}=>roles/iam.serviceAccountUser"
  ]
}

module "network" {
  source       = "terraform-google-modules/network/google"
  version      = "5.2.0"
  project_id   = var.project_id
  network_name = var.network_name
  subnets = [
    {
      subnet_name   = var.subnetwork_name
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region
    },
  ]
  secondary_ranges = {
    "${var.subnetwork_name}" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}

module "gke" {
  source                   = "terraform-google-modules/kubernetes-engine/google"
  version                  = "23.3.0"
  depends_on               = [module.sa, module.network]
  project_id               = var.project_id
  name                     = var.cluster_name
  regional                 = true
  region                   = var.region
  zones                    = var.zones
  network                  = module.network.network_name
  subnetwork               = module.network.subnets_names[0]
  ip_range_pods            = var.ip_range_pods_name
  ip_range_services        = var.ip_range_services_name
  create_service_account   = false
  remove_default_node_pool = true

  node_pools = [
    {
      name               = var.node_pool_name
      machine_type       = var.node_machine_type
      initial_node_count = 1
      autoscaling        = false
      disk_size_gb       = 10

      service_account = module.sa.email
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  timeouts = {
    create = "30m"
    delete = "30m"
    update = "30m"
  }
}
