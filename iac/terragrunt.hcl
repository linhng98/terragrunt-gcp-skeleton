locals {
  project_vars = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  env_vars     = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  org = {
    org_name = "realsnkr"
    org_id   = "656136594954"
  }
  project_id = local.project_vars.locals.project_id
}

# Generate an google provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"

  contents = <<EOF
provider "google" {
  project = "${local.project_id}"
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in a bucket
remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    prefix   = "${path_relative_to_include()}/terraform.tfstate"
    bucket   = "realsnkr-terraform-state"
    project  = "realsnkr-root"
    location = "asia-southeast1"
  }
}

terraform_version_constraint = ">= 1.3.0"


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

inputs = merge(
  local.project_vars.locals,
  local.env_vars.locals,
  local.org,
)
