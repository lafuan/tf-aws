variable "region" {
  default = "us-west-2"
  type    = string
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
  type    = string
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
  type    = string
}

variable "availability_zone" {
  default = "us-west-2a"
  type    = string
}
