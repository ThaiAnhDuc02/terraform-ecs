# Setup RDS
## Setup subnet group
resource "aws_db_subnet_group" "subnet_group" {
  name = "${lower(var.compute_root_name)}-subnet-group-db"

  subnet_ids = [
    var.subnet_private1_id,
    var.subnet_private2_id
  ]

  tags = {
    Name = "${lower(var.compute_root_name)}-subnet-group-db"
    Type = "RDS-Subnet-Group"
    Author = var.author
  }
}

## Setup Multi-AZ DB Instance
resource "aws_db_instance" "rds" {
  identifier = "fcjrdsinstance"
  engine = "mysql"
  engine_version = "8.0.39"
  instance_class = "db.m5.large"
  allocated_storage = 20
  multi_az = true
  storage_type = "gp3"
  username = var.db_username
  password = var.db_password
  db_name = var.db_name
  port = 3306
  publicly_accessible = false
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids = var.security_group_ids
  
  tags = {
    Name = "${lower(var.compute_root_name)}-rds-instance"
    Type = "RDS-Instance"
    DatabaseEngine = "MySQL"
    Author = var.author
  }
}