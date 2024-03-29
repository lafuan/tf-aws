variable "identifier" {
  type = string
  default = "mysql1"
}

variable "db_name" {
  type = string
  default = "instance1"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "5.7"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "username" {
  type = string
  default = "admin"
}

variable "password" {
  type = string
  default = "password"
}

variable "security_group_id" {}

data "aws_security_group" "selected" {
  id = var.security_group_id

    tags = {
    Name = "ecs-sg"
  }
}


variable "publicly_accessible" {
  type    = bool
  default = true
}