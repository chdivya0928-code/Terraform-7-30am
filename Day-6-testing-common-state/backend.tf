terraform {
  backend "s3" {
    bucket = "dev-test-naresh"
    #key    = "terraform.tfstate" # if same path already using in diff directory not a good practice to use here
    key    = "terraform-day6.tfstate" # good practice to use here
    region = "us-east-1"
  }
}


# here we are using the same bucket but different key for different days so that we can have separte 
# if we use common s3 path for two different directories you may destory or modify existing resources
