locals {
  project_id = "${basename(get_terragrunt_dir())}"
  project    = "${basename(get_terragrunt_dir())}"
}
