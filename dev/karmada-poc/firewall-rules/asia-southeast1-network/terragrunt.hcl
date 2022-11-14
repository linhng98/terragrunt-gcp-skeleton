terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-network.git//modules/firewall-rules"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  network_name = "${basename(get_terragrunt_dir())}"
}

inputs = {
  network_name = local.network_name

  rules = [
    {
      name        = "allow-ssh-ingress"
      description             = null
      priority                = null
      direction   = "INGRESS"
      ranges      = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags = ["allow-ssh-ingress"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    },
    {
      name        = "allow-nginx-ingress-http-ingress"
      description             = null
      priority                = null
      direction   = "INGRESS"
      ranges      = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags = ["allow-nginx-ingress-http-ingress"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["30080", "30443"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    },
  ]
}
