output "airflow_url" {
  value = "http://${data.kubernetes_service.airflow.status.0.load_balancer.0.ingress.0.ip}:8080"
}

output "airflow_username" {
  value = var.airflow_username
}

output "airflow_password" {
  value = var.airflow_password
}
