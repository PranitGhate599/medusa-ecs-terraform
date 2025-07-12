variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Name of the project (prefix for resource names)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g. dev, prod)"
  type        = string
  default     = "dev"
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "db_user" {
  description = "PostgreSQL username"
  type        = string
}

variable "db_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432
}

variable "ecr_image_url" {
  description = "Full ECR image URL, including tag"
  type        = string
}

variable "fargate_cpu" {
  description = "CPU units for ECS Fargate task"
  type        = string
  default     = "512"
}

variable "fargate_memory" {
  description = "Memory (MiB) for ECS Fargate task"
  type        = string
  default     = "1024"
}

variable "jwt_secret" {
  description = "JWT secret for Medusa"
  type        = string
  sensitive   = true
}

variable "cookie_secret" {
  description = "Cookie secret for Medusa"
  type        = string
  sensitive   = true
}

variable "auth_cors" {
  description = "Auth CORS origins"
  type        = string
  default     = "*"
}

variable "store_cors" {
  description = "Store CORS origins"
  type        = string
  default     = "*"
}

variable "admin_cors" {
  description = "Admin CORS origins"
  type        = string
  default     = "*"
}

variable "redis_url" {
  description = "Redis connection URL (if used by Medusa)"
  type        = string
  default     = ""
}

variable "medusa_worker_mode" {
  description = "Medusa worker mode: server or worker"
  type        = string
  default     = "server"
}
