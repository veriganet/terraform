terraform {
  source = "git::git@github.com:veriganet/terraform-module-do-database//clusterpg"
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
  name  = "postgresql0"
  engine = "pg"
  engine_version = "13"
  node_count = "2"
  region = "nyc1"
  size = "db-s-1vcpu-2gb"
  private_network_uuid = dependency.vpc.outputs.vpc_id

  firewall_rules = [
    {
      "type": "k8s"
      "value": dependency.k8s.outputs.id
    },
    {
      "type": "ip_addr"
      "value": dependency.vpc.outputs.ip_range
    }
  ]
}
