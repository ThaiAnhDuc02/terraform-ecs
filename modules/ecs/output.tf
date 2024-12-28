# Output
output "cluster_id" {
  value = aws_ecs_cluster.my_ecs_cluster.id
}

output "cluster_arn" {
  value = aws_ecs_cluster.my_ecs_cluster.arn
}

output "backend_task_definition_id" {
  value = aws_ecs_task_definition.backend_taskdef.id
}

output "backend_task_definition_arn" {
  value = aws_ecs_task_definition.backend_taskdef.arn
}

output "frontend_task_definition_id" {
  value = aws_ecs_task_definition.frontend_taskdef.id
}

output "frontend_task_definition_arn" {
  value = aws_ecs_task_definition.frontend_taskdef.arn
}
