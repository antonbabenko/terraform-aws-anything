# This repository contains content for my talk "Manage any AWS resource with Terraform".


## Available types of AWS resources:

1. Supported by Terraform AWS provider - 1-terraform
2. Supported only by AWS CloudFormation, but not by Terraform AWS provider - 2-cloudformation
3. Supported by AWS SDK/CLI and not in AWS CloudFormation - 3-cli
4. Partially supported by Terraform AWS provider (some arguments are not supported) - 4-partial-terraform
5. Not supported in AWS CLI/SDK. [Good luck with Selenium!](https://aws.amazon.com/about-aws/whats-new/2020/01/aws-device-farm-announces-desktop-browser-testing-using-selenium/) or take a look at [Ian's work with Puppeteer](https://github.com/iann0036/aws-account-controller) :trollface: :trollface: :trollface:


## Available solutions to manage AWS resources using Terraform include:

1. Use `local-exec` provisioner with `aws-cli`
2. Use [`shell` provider](https://github.com/scottwinkler/terraform-provider-shell)
3. Patch the [Terraform AWS provider](https://github.com/terraform-providers/terraform-provider-aws/) using golang


## Flow:

1. Import existing resources into state

2. Refactoring states:
  - from/to module
  - to another state-file
  - `terraform state list | grep -v module..... | xargs -Ixx terraform state rm xx`

3. Migrate from AWS Cloudformation to Terraform


## See also

1. Talk "I Can’t Do This With Terraform, Now What?" by Patrick Conheady given at HashiTalks 2020. [See this repository](https://github.com/pacon-vib/tfcando) and [this recording](https://www.hashicorp.com/resources/i-can-t-do-this-with-terraform-now-what).
