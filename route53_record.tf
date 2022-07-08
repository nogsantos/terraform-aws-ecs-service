# =============================================================================
# Terraform
# =============================================================================
#
# Route 53 Record
# -----------------------------------------------------------------------------
resource "aws_route53_record" "cname" {
  zone_id = var.route_zone_id
  name    = format("%s.%s", var.service_name, var.route_zone_name)
  type    = "CNAME"
  ttl     = "300"
  records = [var.dns_name]
}
