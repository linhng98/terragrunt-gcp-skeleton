terraform {
  source = "git::https://github.com/terraform-google-modules/terraform-google-project-factory.git//./"
}

include {
  path = find_in_parent_folders()
  expose = true
}


inputs = {
  random_project_id = false
  name              = include.inputs.project_id
  org_id            = include.inputs.org_id
  billing_account   = include.inputs.billing_account
  folder_id         = include.inputs.folder_id
}
