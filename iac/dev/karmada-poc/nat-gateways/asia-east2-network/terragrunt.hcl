terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-cloud-router.git//./"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path = "../../vpc/asia-east2-network"
}

inputs = {
  name    = "cloud-router-${basename(get_terragrunt_dir())}"
  network = dependency.vpc.outputs.network_name
  region  = "asia-east2"

  nats = [
    {
      name = "cloud-nat-${basename(get_terragrunt_dir())}"
    },
  ]
}
