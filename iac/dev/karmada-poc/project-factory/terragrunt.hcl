terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-project-factory.git//./"
}

include {
  path   = find_in_parent_folders()
  expose = true
}


inputs = {
  random_project_id = false
  name              = include.inputs.project_id
  activate_apis = [
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com",
    "redis.googleapis.com",
    "dns.googleapis.com",
  ]
}
