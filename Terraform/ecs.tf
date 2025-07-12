resource "aws_ecs_cluster" "medusa" {
  name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "medusa"
      image     = var.ecr_image_url
      essential = true
      portMappings = [{
        containerPort = 9000
        protocol      = "tcp"
      }]
      environment = [
        { name = "DATABASE_URL", value = var.database_url }
      ]
    }
  ])

  execution_role_arn = aws_iam_role.ecs_task_exec.arn
  task_role_arn      = aws_iam_role.ecs_task_exec.arn
}
