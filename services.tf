# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
resource "aws_ecs_service" "service" {
  name                 = var.service_name
  cluster              = var.cluster_id
  task_definition      = aws_ecs_task_definition.task.arn
  desired_count        = var.desired_tasks
  depends_on           = [aws_lb_listener_rule.service]
  force_new_deployment = true

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
}
