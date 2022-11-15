terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-kubernetes-engine.git//modules/private-cluster"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

locals {
  cluster_name = "${basename(get_terragrunt_dir())}"
}

dependency "vpc" {
  config_path = "../../vpc/asia-southeast1-network"
}

inputs = {
  name               = local.cluster_name
  region             = "asia-southeast1"
  regional           = true
  network            = dependency.vpc.outputs.network_name
  subnetwork         = "${local.cluster_name}-primary-subnet"
  kubernetes_version = "1.23.11-gke.300"
  #master_authorized_networks = [
  #  {
  #    cidr_block   = "192.168.0.0/21"
  #    display_name = "karmada-subnet"
  #  }
  #]
  maintenance_start_time    = "18:00"
  maintenance_end_time      = "21:00"
  ip_range_pods             = "${local.cluster_name}-pod-secondary-subnet"
  ip_range_services         = "${local.cluster_name}-service-secondary-subnet"
  enable_private_endpoint   = false
  enable_private_nodes      = true
  remove_default_node_pool  = true
  default_max_pods_per_node = 110
  create_service_account    = true
  master_ipv4_cidr_block = "10.255.255.32/28"

  node_pools = [
    {
      name         = "worker-pool"
      machine_type = "n1-standard-1"
      min_count    = 1
      max_count    = 2
      disk_size_gb = 100
      disk_type    = "pd-standard"
      auto_repair  = true
      auto_upgrade = true
      preemptible  = true
    },
  ]
}
