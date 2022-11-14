terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-kubernetes-engine.git//./"
}

include {
  path = find_in_parent_folders()
  expose = true
}

locals {
  cluster_name = "${basename(get_terragrunt_dir())}"
}

dependency "vpc" {
  config_path = "../../vpc/asia-east2-network"
}

inputs = {
  name = local.cluster_name
  region = 
  regional = true
}
