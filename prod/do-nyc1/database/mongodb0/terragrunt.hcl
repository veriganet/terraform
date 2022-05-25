terraform {
  source = "git::git@github.com:veriganet/terraform-module-do-database//clustermongodb"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc/main-nyc1"
}

dependency "k8s" {
  config_path = "../../k8s/k8s-k8s1"
}

inputs = {
  name  = "mongodb0"
  engine = "mongodb"
  engine_version = "4"
  node_count = "3"
  region = "nyc1"
  size = "db-s-1vcpu-1gb"
  private_network_uuid = dependency.vpc.outputs.vpc_id

  firewall_rules = [
    {
      "type": "k8s"
      "value": dependency.k8s.outputs.id
    }
  ]
}
