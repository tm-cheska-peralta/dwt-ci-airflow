resource "aws_flow_log" "this" {
  count = var.enable_flow_log ? 1 : 0

  log_destination      = var.flow_log_destination_arn
  log_destination_type = var.flow_log_destination_type
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id

  tags = var.tags
}
