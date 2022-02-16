terraform {
  source = "git::git@github.com:veriganet/terraform-module-do-kubernetes//kubernetes"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc/main"
}

inputs = {
  name = "k8s1"
  default_pool_auto_scale = true
  default_pool_min_nodes = "4"
  default_pool_max_nodes = "6"
  default_pool_size = "s-4vcpu-8gb"
  k8s_version = "1.21.9-do.0"
  ha = true
  region = "lon1"
  vpc_uuid = dependency.vpc.outputs.vpc_id
}
