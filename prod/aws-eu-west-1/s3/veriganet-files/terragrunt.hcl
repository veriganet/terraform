terraform {
  source = "git@github.com:veriganet/terraform-module-s3.git//s3"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

locals {
  name = "veriganet-files"
}


inputs = {
  tfversion = "0.14.7"

  name               = local.name
  region             = "eu-west-1"
  versioning_enabled = false

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
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

  cors_rules = [
    {
      allowed_headers: "*"
      allowed_methods: "GET"
      allowed_origins: "*"
      expose_headers: "Authorization"
      max_age_seconds: "3000"
    }
  ]

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
        },
		{
			"Sid": "PublicReadForGetBucketObjects",
			"Effect": "Allow",
			"Principal": {
				"AWS": "*"
			},
			"Action": "s3:GetObject",
			"Resource": "arn:aws:s3:::${local.name}/*"
		}
    ]
}
EOT
}
