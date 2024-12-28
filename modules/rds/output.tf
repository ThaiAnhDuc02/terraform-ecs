output "db_instance_id" {
  value = aws_db_instance.rds.id
}

output "db_instance_arn" {
  value = aws_db_instance.rds.arn
}

output "db_instance_identifier" {
  value = aws_db_instance.rds.identifier
}

output "db_instance_endpoint" {
  value = regex("^(.*?):", aws_db_instance.rds.endpoint)[0]  # Sử dụng hàm regex để lấy phần host từ endpoint
}