provider "aws" {
  region     = "ap-southeast-3"

}

data "aws_security_group" "selected" {
  tags = {
    Name = "ecs-sg"
  }
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = ["Subnet1"]
  }
 
}

resource "aws_ecs_cluster" "cluster" {
  name = "cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = "service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = 512
  memory                   = 1024
  container_definitions    = <<EOF
  [
    {
      "name"      : "nginx",
      "image"     : "nginx:1.23.1",
      "cpu"       : 512,
      "memory"    : 1024,
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort"      : 80
        }
      ]
    }
  ]
  EOF
}

resource "aws_ecs_service" "service" {
  name             = "service"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task.id
  desired_count    = 1
  launch_type      = "EC2"

  network_configuration {
    assign_public_ip = false
    subnets          = [data.aws_subnet.selected.id]
    security_groups  = [data.aws_security_group.selected.id]
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}