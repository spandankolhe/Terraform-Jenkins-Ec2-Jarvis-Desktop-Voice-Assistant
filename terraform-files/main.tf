provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "python_server" {
  ami = var.my_ami
  key_name = var.my_key
  instance_type = var.my_type
  tags = {
    Name = "python_server"
  }
  vpc_security_group_ids = [aws_security_group.python-app-sg.id]

}

resource "aws_security_group" "python-app-sg" {
   name = "python-app-sg"
   ingress  {
    description = "allow ssh"
    to_port = 22
    from_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }

     ingress  {
    description = "allow python req"
    to_port = 5000
    from_port = 5000
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    description = "allow all req"
    to_port = 0
    from_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
    }
}