provider "aws" {
  region     = "ap-southeast-3"

}


resource "aws_db_instance" "main_instance" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  publicly_accessible    = var.publicly_accessible
}



