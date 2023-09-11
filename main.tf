provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "one" {
  name = "launch_wizard new"

  ingress {

    from_port   = 22
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "two" {
  ami             = "ami-01c647eace872fc02"
  security_groups = [aws_security_group.one.name]
  instance_type   = "t2.medium"
}

provider "aws" {
  region = "ap-southeast-1"
  alias  = "paris"
}

resource "aws_instance" "three" {
  ami           = "ami-01c647eace872fc02"
  instance_type = "t2.micro"
  provider      = aws.paris
  tags = {
    name = "vm1"
  }
}

