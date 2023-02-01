variable "eks_cluster" {
  default = "EKS Cluster 1"
}

data "aws_subnet" "selected" {
 filter {
    name   = "tag:Name"
    values = ["Private Subnet 1", "Private Subnet 2"]
  }
}

variable "desired_size" {
  default = "1"
}

variable "min_size" {
  default = "1"
}

variable "max_size" {
  default = "1"
}