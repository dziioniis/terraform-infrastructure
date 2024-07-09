resource "random_password" "password" {
  min_upper = 1
  min_lower = 1
  min_numeric = 1
  special = false
  length = 16
  upper = true

  lifecycle {
    prevent_destroy = false
  }

  keepers = {
    date = "2023-06-19"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = var.prefix
  description = "DB subnet group for ${var.prefix}"
  subnet_ids = var.subnet_ids
}

resource "aws_rds_cluster" "postgres" {
  cluster_identifier = var.prefix
  engine = "aurora-postgresql"
  engine_version = "16.2"

  deletion_protection = true

  master_username = var.project_name
  master_password = random_password.password.result
  database_name = var.project_name

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.id

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  apply_immediately = true

#   backtrack_window = 0

  final_snapshot_identifier = var.prefix
}

resource "aws_rds_cluster_instance" "cluster_instance_1" {
  cluster_identifier = aws_rds_cluster.postgres.id
  instance_class = "db.t3.medium"
  engine = aws_rds_cluster.postgres.engine
  engine_version = aws_rds_cluster.postgres.engine_version

  publicly_accessible = true
#   db_parameter_group_name = var.is_localstack ? null :aws_db_parameter_group.default[0].id // bugbug, localstack: Invalid type when serializing DBParameterGroupStatus
#   auto_minor_version_upgrade = false
#   performance_insights_enabled = terraform.workspace == "prod" ? true : false
#   performance_insights_retention_period = terraform.workspace == "prod" ? 62 : null

#   monitoring_interval = 30
#   monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn

#   ca_cert_identifier = "rds-ca-rsa2048-g1"
}


resource "aws_secretsmanager_secret" "db_credentials" {
  name = "${terraform.workspace}--${var.project_name}--rds-db-credentials"
  recovery_window_in_days = 7

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials_secret_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = aws_rds_cluster.postgres.master_username
    password = aws_rds_cluster.postgres.master_password
    engine = aws_rds_cluster.postgres.engine
    host = aws_rds_cluster.postgres.endpoint
    port = aws_rds_cluster.postgres.port
    dbname = aws_rds_cluster.postgres.database_name
    dbClusterIdentifier = aws_rds_cluster.postgres.cluster_identifier
  })
}


resource "aws_security_group" "db_sg" {
  name_prefix = "db-"

  vpc_id = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}