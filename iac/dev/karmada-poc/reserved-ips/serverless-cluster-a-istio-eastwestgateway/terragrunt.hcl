terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-address//./"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  names    = ["external-ip-${basename(get_terragrunt_dir())}"]
  region  = "asia-southeast2"
  address_type = "EXTERNAL"
}
