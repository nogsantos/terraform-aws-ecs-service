# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
# Cluster Execution Policy
resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = format("%s-%s-role_policy", var.cluster_name, var.service_name)
  policy = file(format("%s/policies/ecs-execution-role-policy.json", path.module))
  role   = aws_iam_role.ecs_execution_role.id
}

# Cluster Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name               = format("%s-%s-ecs_task_role", var.cluster_name, var.service_name)
  assume_role_policy = file(format("%s/policies/ecs-task-execution-role.json", path.module))
}

# s3
resource "aws_iam_role_policy_attachment" "s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.ecs_execution_role.name
}

# ssm
resource "aws_iam_role_policy_attachment" "ssm" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  role       = aws_iam_role.ecs_execution_role.name
}

# ecs
resource "aws_iam_role_policy_attachment" "ecs" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_execution_role.name
}

# sns
resource "aws_iam_role_policy_attachment" "sns" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
  role       = aws_iam_role.ecs_execution_role.name
}
