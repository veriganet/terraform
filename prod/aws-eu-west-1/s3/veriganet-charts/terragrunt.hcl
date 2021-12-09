terraform {
  source = "git@github.com:veriganet/terraform-module-s3.git//s3"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

locals {
  name = "veriganet-charts"
}


inputs = {
  tfversion = "0.14.7"

  name               = local.name
  region             = "eu-west-1"
  versioning_enabled = false

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  user_enable             = true

  # lifecycle_rules = [
  #   {
  #     enabled = false
  #     prefix = ""
  #     abort_incomplete_multipart_upload_days = 7
  #     expiration_days = 28
  #     #expiration_date =
  #     expired_object_delete_marker = false
  #   }
  # ]

  # server_side_encryption_configuration_rules = [
  #  {
  #    sse_algorithm = "AES256"
  #  },
  # ]
  # server_side_encryption_configuration_rules = [{}]

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Id": "DefaultS3Policy",
    "Statement": [
        {
            "Sid": "FullPermissionForUser",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "arn:aws:iam::${get_aws_account_id()}:user/${local.name}"
                ]
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${local.name}",
                "arn:aws:s3:::${local.name}/*"
            ]
        }
    ]
}
EOT

}
