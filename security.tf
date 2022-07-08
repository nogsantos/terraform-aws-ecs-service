# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
resource "aws_security_group" "service_sg" {
  name        = format("%s-%s-service-sg", var.cluster_name, var.service_name)
  description = format("%s-%s", var.cluster_name, var.service_name)
  vpc_id      = var.environment_data.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-%s-sg", var.cluster_name, var.service_name)
  }
}

# Should be restricted, VPC cird
resource "aws_security_group_rule" "vpc" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [var.environment_data.vpc_ipv4_cird]
  security_group_id = aws_security_group.service_sg.id
}
