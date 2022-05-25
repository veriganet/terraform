terraform {
  source = "git::git@github.com:veriganet/terraform-module-do-kubernetes//nodepool"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "k8s" {
  config_path = "../k8s-k8s1"
}

inputs = {
  cluster_id = dependency.k8s.outputs.id
  name = "droneciexec0"
  node_count = "1"
  auto_scale = false
  size = "s-8vcpu-16gb"

  labels = {
    "role" = "droneciexec"
  }

  taint_key = "droneciexec"
  taint_value = "true"
  taint_effect = "NoSchedule"

  tags = ["droneci", "droneciexec"]
}
