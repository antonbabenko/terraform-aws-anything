resource "random_pet" "this" {
  length = 2

  # You can use keepers to seed randomness in your configs instead of running "terraform taint" every time :)
  keepers = {
    hash = filemd5("main.tf")
  }
}

resource "aws_s3_bucket" "this" {
  bucket = "hello-${random_pet.this.id}"
}

output "this_s3_bucket_id" {
  value = aws_s3_bucket.this.id
}
