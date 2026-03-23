# Creation of vpc, subnets, internet gateway, route table, security group


resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "prod-vpc"
  }
}
# public subnets
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "prod-subnet"
  }
}

# private subnets
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "prod-subnet-2"
  }
}

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "prod-internet-gateway"
  }
}
# create route table and associate with public subnet
resource "aws_route_table" "prod" {
  vpc_id = aws_vpc.name.id
    route  {
       cidr_block = "0.0.0.0/0"
       gateway_id = aws_internet_gateway.prod.id
  }
}

resource "aws_route_table_association" "prod" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.prod.id
}

resource "aws_security_group" "prod" {
  name        = "prod-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.name.id

  # inbound rules to allow SSH and traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound rules to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "prod" {
  ami             = "ami-03caad32a158f72db"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.prod.id]
  tags = {
    Name = "prod_instance"
  }
}