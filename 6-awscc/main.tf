provider "aws" {
  region = "eu-west-1"
}

provider "awscc" {
  region = "eu-west-1"
}

resource "random_pet" "this" {
  length = 2
}

resource "awscc_..." "this" {
  name = random_pet.this.id
}

# output "this_devicefarm_project_arn" {
#   value = aws_devicefarm_project.this.arn
# }

resource "aws_athena_workgroup" "test" {
  force_destroy = true
  name          = "sdgsg"
  #   actions {
  #     crawler_name = "sdg"
  #     arguments    = "sdg"
  #   }
}

resource "awscc_glu" "test" {
  name = "test"
}

resource "aws_cloudformation_stack_set" "name" {
  name = "test"
}
