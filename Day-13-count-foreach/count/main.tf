variable "ami_id" {
  description = "passing values to ami_id"
  default = ""
  type = string
}

variable "instance_type" {
  description = "passing values to instance_type"
  default = ""
  type = string
}




#resource "aws_instance" "dev" {
 # ami = var.ami_id
#  instance_type = var.instance_type
#count = 2
#  tags = {
#    Name = "dev-instance" # so here we are creating 2 instances with same name 
#  }
 # tags = {
 #   Name = "dev-instance-${count.index + 1}" # here we are creating 2 instances with different names
 # }
#}

# different names for each instance
variable "env" {
  description = "environment"
  default =["dev","prod"]
    type = list(string)
    # while removing test server from this list prod deleted and test renamed as a prod this is not recommended
}

resource "aws_instance" "name" {
  ami = var.ami_id
  instance_type = var.instance_type
  count = length(var.env)
  tags = {
    Name = var.env[count.index] # so here we are creating 3 instances with different names based on the environment
  }
}