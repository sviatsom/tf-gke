terraform {
  backend "gcs" {
    bucket = "<bucket-name>"
    prefix = "gke-tf/state"
  }
}
