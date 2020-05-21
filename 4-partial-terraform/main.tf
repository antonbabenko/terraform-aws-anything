locals {
  aws_cli_command = "aws --output json --profile anton-demo --region eu-west-1"
}

# Logical directory mappings for SFTP users are not supported by Terraform AWS Provider v2.62.0 (21.5.2020)
# Related open issue: https://github.com/terraform-providers/terraform-provider-aws/issues/11281
#
# This is not supported yet!
//resource "aws_transfer_user" "sftp_user_dbs" {
//  # other options
//  # ...
//  home_directory_type = "LOGICAL"
//  home_directory_mapping = {
//    entry = "your-personal-report.pdf"
//    target = "/bucket3/customized-reports/${transfer:UserName}.pdf"
//  }
//}

// Download and compile from https://github.com/scottwinkler/terraform-provider-shell
provider "shell" {}

resource "shell_script" "user1_home_directory_mapping" {
  lifecycle_commands {
    create = "aws transfer update-user --server-id ${aws_transfer_server.this.id} --user-name ${aws_transfer_user.user1.user_name} --home-directory-type LOGICAL --home-directory-mappings '${jsonencode([{ Entry : "/my_home", Target : "/home/user1" }])}'"
    delete = "aws transfer update-user --server-id ${aws_transfer_server.this.id} --user-name ${aws_transfer_user.user1.user_name} --home-directory-type PATH"
  }
}

######################################
# The rest of Terraform code is below
######################################

resource "aws_transfer_server" "this" {
  identity_provider_type = "SERVICE_MANAGED"
}

resource "aws_transfer_user" "user1" {
  server_id = aws_transfer_server.this.id
  role      = aws_iam_role.user1.arn
  user_name = "user1"
}

resource "aws_iam_role" "user1" {
  name_prefix        = "user1-"
  assume_role_policy = data.aws_iam_policy_document.user1_assume_role.json
}

data "aws_iam_policy_document" "user1_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

##########
# Outputs
##########

output "user1_home_directory_mapping_shell_script_output" {
  value = shell_script.user1_home_directory_mapping.output
}

output "user1_transfer_user_id" {
  value = aws_transfer_user.user1.id
}
