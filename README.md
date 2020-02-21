# This repository contains content for my talk "Manage any AWS resource with Terraform".


## Available types of AWS resources:

1. Supported by Terraform AWS provider - 1-terraform
2. Supported only by AWS CloudFormation, but not by Terraform AWS provider - 2-cloudformation
3. Supported by AWS SDK/CLI and not in AWS CloudFormation - 3-cli
4. Partially supported by Terraform AWS provider (some arguments are not supported)
5. Not supported in AWS CLI/SDK. [Good luck with Selenium!](https://aws.amazon.com/about-aws/whats-new/2020/01/aws-device-farm-announces-desktop-browser-testing-using-selenium/)


## Available solutions to manage AWS resources using Terraform include:

1. Use `local-exec` provisioner with `aws-cli`
2. Use [`shell` provider](https://github.com/scottwinkler/terraform-provider-shell)
3. Patch the [Terraform AWS provider](https://github.com/terraform-providers/terraform-provider-aws/) using golang


## Flow:

1. Import existing resources into state

2. Refactoring states:
  - from/to module
  - to another state-file

3. Migrate from AWS Cloudformation to Terraform


## More info

1. Talk "I Can’t Do This With Terraform, Now What?" by Patrick Conheady given at HashiTalks 2020. [See this repository](https://github.com/pacon-vib/tfcando).
