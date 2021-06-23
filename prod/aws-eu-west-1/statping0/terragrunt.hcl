terraform {
  source = "git::git@github.com:veriganet/terraform-module-aws-lightsail.git//instance"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "staticip" {
  config_path = "../staticip"
}

inputs = {
  instance_name = "statping0"
  bundle_id = "micro_2_0"
  blueprint_id = "debian_10"
  key_pair_name = "zer"
  static_ip_name = "statping0-ip"
}