terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-vm.git//modules/compute_instance"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

dependency "template" {
  config_path = "../../instance-templates/jumpserver"
}

dependency "external_ip" {
  config_path = "../../reserved-ips/wireguard-server"
}

inputs = {
  instance_template = dependency.template.outputs.self_link
  subnetwork        = "karmada-cluster-primary-subnet"
  hostname          = "wireguard-server"
  zone              = "asia-southeast1-c"
  access_config = [{
    nat_ip       = dependency.external_ip.outputs.addresses[0]
    network_tier = "PREMIUM"
  }]
}
