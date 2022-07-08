variable "container_port" {}
variable "environment" {}
variable "cluster_listener" {}
variable "cluster_name" {}
variable "cluster_id" {}
variable "service_name" {}
variable "region" { default = "us-east-1" }
variable "service_protocol" { default = "http" }
variable "service_launch_type" { default = "EC2" }
variable "is_public" { default = true }
variable "platform_version" {
  default = "LATEST"
}
variable "service_healthcheck" {
  type = map(any)
  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 20
    matcher             = "200"
    path                = "/healthcheck"
    port                = "traffic-port"
  }
}
variable "desired_tasks" { default = 2 }
variable "min_tasks" { default = 2 }
variable "max_tasks" { default = 3 }
variable "desired_task_cpu" { default = 128 }
variable "desired_task_mem" { default = 256 }
variable "cpu_to_scale_up" { default = 80 }
variable "cpu_to_scale_down" { default = 30 }
variable "cpu_verification_period" { default = 60 }
variable "cpu_evaluation_periods" { default = 5 }
variable "service_base_path" {
  type = list(any)
}
variable "availability_zones" {}
variable "dns_name" {}
variable "route_zone_id" {}
variable "route_zone_name" {}
variable "environment_data" {
  type = object({
    vpc_id        = string
    vpc_ipv4_cird = string
    subnets       = list(string)
  })
  description = "Environment network configurations"
}

variable "env" {
  type = list(
    object({
      name  = string
      value = string
    })
  )
}
variable "secrets" {
  type = list(
    object({
      name      = string
      valueFrom = string
    })
  )
}
