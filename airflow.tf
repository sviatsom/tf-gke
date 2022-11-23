resource "helm_release" "airflow" {
  name             = "airflow"
  chart            = "apache-airflow/airflow"
  version          = "1.7.0"
  create_namespace = true
  namespace        = "airflow"
  timeout          = 600
  max_history      = 3

  set {
    name  = "webserver.defaultUser.username"
    value = var.airflow_username
  }

  set {
    name  = "webserver.defaultUser.password"
    value = var.airflow_password
  }

  set {
    name  = "webserver.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "config.webserver.expose_config"
    value = "True"
  }

  set {
    name  = "createUserJob.useHelmHooks"
    value = "false"
  }

  set {
    name  = "migrateDatabaseJob.useHelmHooks"
    value = "false"
  }
}

data "kubernetes_service" "airflow" {
  metadata {
    name      = "airflow-webserver"
    namespace = "airflow"
  }

  depends_on = [
    helm_release.airflow
  ]
}
