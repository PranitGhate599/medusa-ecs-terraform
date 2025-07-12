output "db_host" {
  description = "PostgreSQL RDS hostname"
  value       = aws_db_instance.postgres.address
}

output "db_port" {
  description = "PostgreSQL port"
  value       = aws_db_instance.postgres.port
}

output "database_url" {
  description = "Full DATABASE_URL connection string for Medusa"
  value       = "postgres://${var.db_user}:${var.db_password}@${aws_db_instance.postgres.address}:${aws_db_instance.postgres.port}/${var.db_name}"
  sensitive   = true
}

output "ecs_cluster_name" {
  description = "ECS Cluster name"
  value       = aws_ecs_cluster.medusa.name
}

output "ecs_task_definition_arn" {
  description = "Latest ECS task definition ARN"
  value       = aws_ecs_task_definition.medusa.arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.medusa_service.name
}

output "load_balancer_dns" {
  description = "Public DNS of the load balancer"
  value       = aws_lb.medusa_lb.dns_name
}
