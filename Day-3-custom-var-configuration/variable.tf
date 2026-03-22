variable "ami_id" {
    description = "passing values to ami_id"
    default = "t2.micro"
    type = string
}
variable "instance_type" {
    description = "passing values to instance_type"
    default = ""
    type = string
}