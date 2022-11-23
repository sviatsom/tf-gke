resource "google_storage_bucket" "tf-state" {
  project       = var.project_id
  name          = var.bucket_name
  location      = var.region
  force_destroy = true
  storage_class = var.storage_class

  versioning {
    enabled = true
  }
}
