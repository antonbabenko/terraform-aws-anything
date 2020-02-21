locals {
  aws_cli_command = "aws --output json --profile anton-demo --region eu-west-1"
}

resource "random_pet" "this" {
  length = 3
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "this" {
  bucket = random_pet.this.id
}

// "Amazon S3 Access Points" feature is not supported in Terraform AWS Provider v2.49.0 (20.2.2020)
// Ref: https://github.com/terraform-providers/terraform-provider-aws/issues/11123
// Ref: https://aws.amazon.com/s3/features/access-points/
// Ref: https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst
//
// # This is not supported yet!
//resource "aws_s3_access_point" "example" {
//  account_id = data.aws_caller_identity.current.account_id
//  bucket     = aws_s3_bucket.this.id
//  name       = "example"
//}

// Download and compile from https://github.com/scottwinkler/terraform-provider-shell
provider "shell" {}

// See code in `3-cli` for another example
resource "shell_script" "aws_cli" {
  lifecycle_commands {
    create = "echo ${local.aws_cli_command} s3control create-access-point --name example-ap --account-id ${data.aws_caller_identity.current.account_id} --bucket ${random_pet.this.id} --public-access-block-configuration BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestrictPublicBuckets=true >&3"
    delete = "echo ${local.aws_cli_command} s3control delete-access-point --name example-ap --account-id ${data.aws_caller_identity.current.account_id} --bucket ${random_pet.this.id}"
  }
}

output "this_s3_bucket_id" {
  value = aws_s3_bucket.this.id
}
