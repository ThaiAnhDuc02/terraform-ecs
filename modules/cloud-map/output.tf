output "sd_namespace_id" {
  value = aws_service_discovery_private_dns_namespace.sd_namespace.id
}

output "sd_service_id" {
  value = aws_service_discovery_service.sd_service.id
}