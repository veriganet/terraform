terraform {
  source = "git@github.com:veriganet/terraform-module-iam.git//user"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  tfversion = "0.14.7"

  name = "droneci-pre"
  policy_description = "IAM user user for droneci pre step"

  policies = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]

}
