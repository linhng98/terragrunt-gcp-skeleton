terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-network.git//./"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  network_name = "${basename(get_terragrunt_dir())}"
}

inputs = {
  network_name = "${local.network_name}"
  subnets = [
    {
      subnet_name           = "serverless-cluster-a-primary-subnet"
      subnet_ip             = "192.168.0.0/21"
      subnet_region         = "asia-southeast2"
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    serverless-cluster-a-primary-subnet = [
      {
        range_name    = "serverless-cluster-a-pod-secondary-subnet"
        ip_cidr_range = "10.0.0.0/14"
      },
      {
        range_name    = "serverless-cluster-a-service-secondary-subnet"
        ip_cidr_range = "10.4.0.0/14"
      }
    ]
  }
}