terraform {
  backend "s3" {
    bucket = "dev-test-naresh"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
