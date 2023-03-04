# S3 bucket configuration for stroring Terraform state
terraform {
  backend "s3" {
    bucket = "some-test-bucket-for-codica-test" // Change the name of the bucket to yours
    key    = "terraform.tfstate"
    region = "eu-central-1"                     // Change the region if needed
  }
}
