# gcp
project_id = "<project-id>"
region     = "us-central1"

# gcs
bucket_name   = "<bucket-name>"
storage_class = "REGIONAL"

# network
network_name           = "gke-network"
subnetwork_name        = "gke-subnet"
ip_range_pods_name     = "ip-range-pods"
ip_range_services_name = "ip-range-services"

# gke
cluster_name      = "gke-airflow"
node_pool_name    = "gke-airflow"
node_machine_type = "e2-medium"
zones             = ["us-central1-a", "us-central1-b", "us-central1-c"]

# airflow
airflow_username = "<airflow-username>"
airflow_password = "<airflow-password>"
