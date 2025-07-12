project       = "medusa-shop"
environment   = "production"

db_name       = "medusa_store"
db_user       = "admin"
db_password   = "StrongPass123"
db_port       = 5432

ecr_image_url = "123456789012.dkr.ecr.us-east-1.amazonaws.com/medusa-backend:abcdef123456"

fargate_cpu    = "1024"
fargate_memory = "2048"

jwt_secret      = "VerySecretJwtKeyHere"
cookie_secret   = "AnotherSecretKey"
auth_cors       = "https://shop.example.com"
store_cors      = "https://shop.example.com"
admin_cors      = "https://admin.example.com"
redis_url       = "redis://:password@redis-host:6379"
medusa_worker_mode = "server"
