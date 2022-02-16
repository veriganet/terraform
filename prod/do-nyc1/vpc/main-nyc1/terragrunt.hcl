terraform {
  source = "git::git@github.com:veriganet/terraform-module-do-net//vpc"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  name = "main-nyc1"
  description = "Main VPC for NYC1 Region"
  ip_range = "10.138.0.0/16"
}
