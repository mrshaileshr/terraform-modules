
module "db_credentials" {
  source = "../secretsManager" # Adjust the path based on your directory structure

  name          = "rds-mysql-credentials2"
  secret_string = jsonencode({
    username = "admin"
    password = "password123"
  })
}

data "aws_secretsmanager_secret" "db_credentials" {
  name = module.db_credentials.id
}

data "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}

locals {
  db_credentials = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "jenkinsdb"
  username               = local.db_credentials.username
  password               = local.db_credentials.password
  vpc_security_group_ids = [var.privateSecuritygp]
  skip_final_snapshot = true
  
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.private_subnets
}


