# Introduction
Let's create a GKE cluster using Terraform with the following requirements:
- use remote backend as a [GCS](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket)
- cluster should be deployed in a specific region and with 3 nodes (one on each zone)
- deploy [Apache Airflow](https://airflow.apache.org/docs/helm-chart/stable/index.html) to the cluster using Terraform [Helm
Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)

# Set up GCP account
Install [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

Link your Google account to the gcloud CLI:
```
gcloud init
gcloud auth application-default login
```

Enable APIs:
```
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable storage.googleapis.com
```

Enable billing for the project by following [these steps](https://cloud.google.com/billing/docs/how-to/modify-project#to_view_the_account_linked_to_a_project_do_the_following)

# Set up Terraform
Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

Define variables in the `vars.tf`
> Add `default` values if necessary

Set variables values in the `terraform.tfvars`

Define providers configuration in the `provider.tf`

Define storage bucket with versioning enabled in the `gcs.tf`

Add configuration for the remote backend in the `backend.tf`

Define GKE cluster in the `gke.tf` 
> Remove the `sa` module if you would like to create service account within the `gke` module, use `create_service_account` parameter for it

# Set up Airflow
Install [Helm](https://helm.sh/docs/intro/install/)

Define Airflow configuration in the `airflow.tf`

Add Airflow chart repository
```
helm repo add apache-airflow https://airflow.apache.org
```
> Alternatively you can define it as a `helm_release.airflow.repository` parameter

Define Airflow URL and credentials as Terraform output in the `output.tf`

# Run Terraform
Initiazlize your working directory with your `tf` configuration files:
```
terraform init
```

Review and apply the configuration:
```
terraform apply
```
