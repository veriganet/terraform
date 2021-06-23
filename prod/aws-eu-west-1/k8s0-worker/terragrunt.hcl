terraform {
  source = "git::git@github.com:veriganet/terraform-module-aws-lightsail.git//k8s-worker"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  instance_count = "2"
  bundle_id = "xlarge_2_0"
  blueprint_id = "debian_10"
  cluster = "k8s0"
  key_pair_name = "zer"
}