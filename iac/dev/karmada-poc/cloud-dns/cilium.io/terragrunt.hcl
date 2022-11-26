terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-cloud-dns.git//./"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path = "../../vpc/asia-southeast1-network"
}

inputs = {
  type       = "private"
  name       = "cilium-clustermesh"
  domain     = "cilium.io."

  private_visibility_config_networks = [
    dependency.vpc.outputs.network_id
  ]

  recordsets = [
    {
      name    = "cilium-cluster-a"
      type    = "A"
      ttl     = 300
      records = [
        "192.168.15.1",
      ]
    },
    {
      name    = "cilium-cluster-b"
      type    = "A"
      ttl     = 300
      records = [
        "192.168.23.1",
      ]
    },
  ]
}
