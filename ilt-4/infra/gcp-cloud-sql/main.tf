resource "random_id" "name" {
  byte_length = 2
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../gcp-vpc/terraform.tfstate"
  }
}

locals {
  instance_name = var.name_override == null ? format("%s-%s-%s", var.name_prefix, var.ilt_name, random_id.name.hex) : var.name_override
}

module "cloud-sql" {
  source = "../../../modules/gcp-cloud-sql"

  project = var.project
  region  = var.region
  name    = local.instance_name
  db_name = var.db_name

  engine       = var.postgres_version
  machine_type = var.machine_type

  deletion_protection = false

  master_user_password = var.master_user_password

  master_user_name = var.master_user_name
  master_user_host = "%"

  private_network = data.terraform_remote_state.vpc.outputs.network_self_link

  custom_labels = {
    test-id = "postgres-private-ip-example"
    ilt     = var.ilt_name
  }
}
