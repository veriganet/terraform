terraform {
  source = "git::git@github.com:zervpn/terraform-module-aws-lightsail.git//staticip"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  names = [
    "vpn0-ip",
    "statping0-ip"
  ]
}