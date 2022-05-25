terraform {
  source = "git::git@github.com:veriganet/terraform-module-do-net//vpc"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  name = "main"
  description = "Main VPC"
  ip_range = "10.136.0.0/16"
}
