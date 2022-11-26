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
      subnet_name           = "karmada-cluster-primary-subnet"
      subnet_ip             = "192.168.0.0/21"
      subnet_region         = "asia-southeast1"
      subnet_private_access = "true"
    },
    {
      subnet_name           = "cilium-cluster-a-primary-subnet"
      subnet_ip             = "192.168.8.0/21"
      subnet_region         = "asia-southeast1"
      subnet_private_access = "true"
    },
    {
      subnet_name           = "cilium-cluster-b-primary-subnet"
      subnet_ip             = "192.168.16.0/21"
      subnet_region         = "asia-southeast1"
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    karmada-cluster-primary-subnet = [
      {
        range_name    = "karmada-cluster-pod-secondary-subnet"
        ip_cidr_range = "10.0.0.0/14"
      },
      {
        range_name    = "karmada-cluster-service-secondary-subnet"
        ip_cidr_range = "10.4.0.0/14"
      }
    ]
    cilium-cluster-a-primary-subnet = [
      {
        range_name    = "cilium-cluster-a-pod-secondary-subnet"
        ip_cidr_range = "10.8.0.0/14"
      },
      {
        range_name    = "cilium-cluster-a-service-secondary-subnet"
        ip_cidr_range = "10.12.0.0/14"
      }
    ]
    cilium-cluster-b-primary-subnet = [
      {
        range_name    = "cilium-cluster-b-pod-secondary-subnet"
        ip_cidr_range = "10.16.0.0/14"
      },
      {
        range_name    = "cilium-cluster-b-service-secondary-subnet"
        ip_cidr_range = "10.20.0.0/14"
      }
    ]
  }
}
