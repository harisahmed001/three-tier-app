provider "postgresql" {
  host            = aws_db_instance.postgres.address
  port            = 5432
  database        = local.postgres_database_name
  username        = var.name
  password        = var.rds_password
  sslmode         = "require"
  connect_timeout = 15
  superuser       = false
}

resource "aws_db_instance" "instance_name" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "12.2"
  instance_class         = "db.t2.micro"
  identifier             = var.name
  name                   = var.name
  username               = var.name
  password               = var.rds_password
  publicly_accessible    = true
  parameter_group_name   = "default.postgres12"
  vpc_security_group_ids = [module.eks.cluster_primary_security_group_id]
  skip_final_snapshot    = true
}

resource "postgresql_role" "user_name" {
  name                = var.name
  login               = true
  password            = var.rds_password
  encrypted_password  = true
  create_database     = true
  create_role         = true
  skip_reassign_owned = true
}

# // POSTGRES
# resource "aws_security_group" "rds_sg" {
#   name = "security_group_name"

#   ingress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     description = "PostgreSQL"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
