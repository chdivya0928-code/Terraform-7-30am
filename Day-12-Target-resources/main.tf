variable "create_specified_resources" {
  type = bool
  default = true
  
}



resource "aws_instance" "name" {
  ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
}

resource "aws_s3_bucket" "name" {
   bucket = var.create_specified_resources
}
  


#we can target specific resources to update or destroy by using -target option in terraform plan and apply commands
#terraform plan -target=aws_instance.name
#if multiple resources we can use -target option multiple times
#terraform plan -target=aws_instance.name -target=aws_s3_bucket.name