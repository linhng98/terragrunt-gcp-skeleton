terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-vm.git//modules/instance_template"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

dependency "vpc" {
  config_path = "../../vpc/asia-southeast1-network"
}

inputs = {
  network = dependency.vpc.outputs.network_self_link
  region = "asia-southeast1"
  subnetwork = "karmada-cluster-primary-subnet"
  machine_type = "n1-standard-1"
  tags = ["allow-ssh-ingress"]
  preemptible = true
  source_image_project = "ubuntu-os-cloud"
  source_image_family = "ubuntu-minimal-2004-lts"
  disk_size_gb = 30
  service_account = null
  metadata = {
    ssh-keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3nj/HBFmqS/LE/RFtV5XDCVEAY2y2o1JdKIN4USMhzOOIhJCDtQbTakfPF8AC9+GeLrG9fs2Jv638Phvs5nOkGYdt0ekoq1Bv6F96wClhMKugeh36v3lRUW3lhhxNUmq8FpdpjYHJeJ6jTnLU//q3SmNDytKmRne7+8g3MDdzubJ6cQRJyxnaM7ctbhRPFfZoW/tHWXYKsz+ub8CPL2JdH7fOT1LzPIwax4H2XQJ+7ZLT0yhHj1t2yTBUibpvpMOe79zmLMrXovmv+tHqBzRjEhtg8utsrtcjhk06xMMGh8HISuYQNZet5v7XpChgqxlawPBCmSnChcSRsOdG7nEOhGDizgVUM6lzapUEDdA7+2co8d6GEe2yjdfl95oG9GtoTtK0pNXljNlZ0nCUZSHdI6GxARNgB+c/0Ubfju8BaHeYYti7I+JqGPKOSp3tje4Ntv69lMtaeBzrTWdQCD7zg42y+HLcc7S8J1Bd4S7ndt15L/RMWk8BPB2nrAqa/9/uqg0IjP+GUtKvJ7qWY0myNuCfR5otmgV6XLKah7cKLJ4A/v8/V8UuOiyPfNewXWbvnXYqvzsOmDUl5QlHIN7fqlVLPdbx3GLzikP21hHzG7HZXnHXj07qXa01bM9VOLgTzaLvkn/aj85RopfE38qItxMBy7MBm5cIF5drJhz+5Q== linh1612340@gmail.com"
  }
  startup_script = <<EOF
!#/bin/bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/bin/kubectl
curl -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-404.0.0-linux-x86_64.tar.gz --output google-cloud-sdk.tar.gz
sudo tar -zxvf google-cloud-sdk.tar.gz -C /opt
sudo ln -sf /opt/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
EOF
}
