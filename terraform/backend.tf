terraform {
  backend "s3" {
    bucket = "some-test-bucket-for-codica-test"
    key    = "terraform.tfstate"
    region = "eu-central-1"
  }
}
