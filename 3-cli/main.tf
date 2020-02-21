locals {
  aws_cli_command = "aws --output json --profile anton-demo --region eu-west-1"
}

resource "random_pet" "this" {
  length = 2
}

// Solution 1
resource "null_resource" "aws_cli" {
  provisioner "local-exec" {
    when    = create
    command = "aws ec2 create-key-pair --key-name testkey --region eu-west-1"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "aws ec2 delete-key-pair --key-name testkey --region eu-west-1"
  }
}

// Solution 2
// Download and compile from https://github.com/scottwinkler/terraform-provider-shell
provider "shell" {}

resource "shell_script" "aws_cli" {
  lifecycle_commands {
    create = "${local.aws_cli_command} ec2 create-key-pair --key-name ${random_pet.this.id} >&3"
    delete = "${local.aws_cli_command} ec2 delete-key-pair --key-name ${random_pet.this.id}"

    // read   = ""
    // update = ""
  }
}

output "aws_cli_shell_script_output" {
  value = shell_script.aws_cli.output
}
