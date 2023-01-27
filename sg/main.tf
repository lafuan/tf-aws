provider "aws" {
 region = "ap-southeast-3"
}

data "aws_vpc" "default" {
 default = true

}

resource "aws_security_group" "web_server_sg" {
 name        = "web-server-sg"
 description = "Allow HTTPS to web server"
 vpc_id      = data.aws_vpc.default.id

ingress {
   description = "HTTPS ingress"
   from_port   = 443
   to_port     = 443
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]

 }

}

resource "aws_security_group" "ssh_access" {
 name        = "ssh_access"
 description = "Allow SSH for EC2"
 vpc_id      = data.aws_vpc.default.id

ingress {
   description = "SSH Access"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

}

resource "aws_security_group" "sg" {
  name   = "ecs-sg"
  description = "SG for ECS NGINX"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    self        = "false"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecs-sg"
  }
}