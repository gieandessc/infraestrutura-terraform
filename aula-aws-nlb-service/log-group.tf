resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${local.container_name}"
  retention_in_days = 7 # Ajuste o período de retenção conforme necessário
}
