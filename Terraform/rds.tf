resource "aws_db_instance" "postgres" {
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  name              = "medusa"
  username          = var.db_user
  password          = var.db_password
  publicly_accessible = false
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}
