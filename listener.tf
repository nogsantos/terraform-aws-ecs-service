# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
resource "aws_lb_listener_rule" "service" {
  listener_arn = var.cluster_listener

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    host_header {
      values = [aws_route53_record.cname.name]
    }
  }
}
