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
