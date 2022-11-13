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
      subnet_name = "serverless-cluster-a-primary-subnet",
      subnet_ip = "192.168.0.0/21",
      subnet_region = "asia-southeast1"
      subnet_private_access = "true"
    },
    {
      subnet_name = "serverless-cluster-b-primary-subnet",
      subnet_ip = "192.168.8.0/21",
      subnet_region = "asia-southeast1"
      subnet_private_access = "true"
    },
  ]

  secondary_ranges = {
    serverless-cluster-a-primary-subnet = [
      {
        range_name = "serverless-cluster-a-pod-secondary-subnet"
        ip_cidr_range = "10.0.0.0/14"
      },
      {
        range_name = "serverless-cluster-a-service-secondary-subnet"
        ip_cidr_range = "10.4.0.0/14"
      }
    ]
    serverless-cluster-b-primary-subnet = [
      {
        range_name = "serverless-cluster-b-pod-secondary-subnet"
        ip_cidr_range = "10.8.0.0/14"
      },
      {
        range_name = "serverless-cluster-b-service-secondary-subnet"
        ip_cidr_range = "10.12.0.0/14"
      }
    ]
  }
}
