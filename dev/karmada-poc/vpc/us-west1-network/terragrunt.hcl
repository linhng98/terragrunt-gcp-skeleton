terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-network.git//./"
}

include {
  path = find_in_parent_folders()
  expose = true
}


inputs = {
  network_name = "${basename(get_terragrunt_dir())}"
  subnets = [
    {
      subnet_name = "karmada-cluster-primary-subnet",
      subnet_ip = "192.168.0.0/21",
      subnet_region = "us-west1"
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    karmada-cluster-primary-subnet = [
      {
        range_name = "karmada-cluster-pod-secondary-subnet"
        ip_cidr_range = "10.0.0.0/14"
      },
      {
        range_name = "karmada-cluster-service-secondary-subnet"
        ip_cidr_range = "10.4.0.0/14"
      }
    ]
  }
}
