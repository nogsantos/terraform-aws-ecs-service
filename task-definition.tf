# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
locals {
  network_mode = "bridge"
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.service_name
  requires_compatibilities = ["EXTERNAL", "EC2"]
  network_mode             = local.network_mode
  cpu                      = var.desired_task_cpu
  memory                   = var.desired_task_mem
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name              = var.service_name
    image             = format("%s:latest", aws_ecr_repository.registry.repository_url)
    cpu               = var.desired_task_cpu
    memory            = var.desired_task_mem
    memoryReservation = var.desired_task_mem
    networkMode       = local.network_mode
    essential         = true
    family            = var.service_name
    portMappings = [
      {
        containerPort = var.container_port
        hostPort      = 0,
        protocol      = "tcp"
      }
    ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.logs.name
        awslogs-region        = var.region
        awslogs-stream-prefix = var.service_name
      }
    }
    healthCheck = {
      retries     = 3,
      command     = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}/healthcheck || exit 1"],
      timeout     = 5,
      interval    = 30,
      startPeriod = null
    }
    environment = var.env
    secrets     = var.secrets
  }])
}
