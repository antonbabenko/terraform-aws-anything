resource "random_pet" "this" {
  length = 2
}

// S3 bucket is obviously well supported by both Terraform and Cloudformation, but still using it for the sake of the simplicity in this example. If you want to try a resource type which is supported just by AWS Cloudformation, try [AWS ManagedBlockchain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/AWS_ManagedBlockchain.html)
resource "aws_cloudformation_stack" "this" {
  name          = "s3-bucket-${random_pet.this.id}"
  template_body = <<EOF
{
  "Resources" : {
     "S3Bucket" : {
        "Type" : "AWS::S3::Bucket",
	      "DeletionPolicy": "Delete",
        "Properties" : {
           "BucketName" : "${random_pet.this.id}"
         }
     }
  }
}
EOF
}

//resource "aws_s3_bucket" "this" {
//  bucket = random_pet.this.id
//}

output "this_cloudformation_stack_id" {
  value = aws_cloudformation_stack.this.id
}
