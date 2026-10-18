# Create subnet group for Aurora Cluster
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "kamyar-wordpress-db-subnets"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

resource "aws_db_instance" "mysql" {
  allocated_storage      = 20
  db_name                = "wordpress"
  engine                 = "mysql"
  engine_version         = "8.0.44"
  instance_class         = "db.t3.micro"
  identifier             = "kamyar-rds-db"
  username               = "wordpressuser"
  password               = var.db_password
  skip_final_snapshot    = true
  backup_retention_period = 7
  multi_az               = true
  storage_encrypted      = true
  vpc_security_group_ids = [aws_security_group.aws_rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.aurora_subnet_group.name

  tags = {
    Name = "kamyar-rds_db_wordpress"
  }
}

# Output the endpoint
output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}
