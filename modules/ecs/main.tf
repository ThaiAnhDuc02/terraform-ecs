# ECS Cluster
resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = "my-ecs-cluster"  # Tên của cluster

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name  = "FCJ-ecs-cluster"
    Type  = "ECS-Cluster"
    Author = var.author
  }
}

# ECS task definition backend
resource "aws_ecs_task_definition" "backend_taskdef" {
  family                   = var.backend_family        # Tên nhóm của task
  network_mode             = "awsvpc"                     # Chế độ network cho ECS
  requires_compatibilities = ["FARGATE"]                  # Loại tương thích, ở đây dùng Fargate
  cpu                      = "4096"                        # CPU cho task
  memory                   = "8192"                        # Bộ nhớ cho task
  execution_role_arn= var.ecs_execution_role_arn
  container_definitions = jsonencode([                    # Định nghĩa container
    {
      name      = "backend"
      image     = var.backend_image                         # Image sử dụng cho container
      cpu       = 2048
      memory    = 4096
      essential = true

      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]

      # Thêm các biến môi trường vào container
      environment = [
        {
          name  = "MYSQL_USER"
          value = var.db_username
        },
        {
          name  = "MYSQL_PASSWORD"
          value = var.db_password
        },
        {
          name  = "MYSQL_DATABASE"
          value = var.mysql_database
        },
        {
          name  = "DB_HOST"
          value = var.db_host
        },
        {
          name  = "DB_DIALECT"
          value = var.db_dialect
        },
        {
          name  = "PORT"
          value = var.be_port
        },
        {
          name  = "JWT_SECRET"
          value = var.jwt_secret
        }
      ]

    }
  ])

  tags = {                                                # Gán tag cho task definition
    Name = "be-task-definition"
  }
}

# ECS task definition frontend
resource "aws_ecs_task_definition" "frontend_taskdef" {
  family                   = var.frontend_family        # Tên nhóm của task
  network_mode             = "awsvpc"                     # Chế độ network cho ECS
  requires_compatibilities = ["FARGATE"]                  # Loại tương thích, ở đây dùng Fargate
  cpu                      = "2048"                        # CPU cho task
  memory                   = "4096"                        # Bộ nhớ cho task
  execution_role_arn= var.ecs_execution_role_arn
  container_definitions = jsonencode([                    # Định nghĩa container
    {
      name      = "frontend"
      image     = var.frontend_image                         # Image sử dụng cho container
      cpu       = 1024                                      
      memory    = 2048
    
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]

      # Thêm các biến môi trường vào container
      environment = [
        {
          name  = "BACKEND_HOST"
          value = var.be_host
        },
        {
          name  = "BACKEND_PORT"
          value = var.be_port
        }
      ]

    }
  ])

  tags = {                                                # Gán tag cho task definition
    Name = "fe-task-definition"
  }
}

