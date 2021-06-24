terraform {
  source = "git@github.com:veriganet/terraform-module-iam.git//user"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  tfversion = "0.14.7"

  name = "droneciecr"
  policy_description = "IAM user user for Drone CI - ECR"

  policies = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  ]

}
