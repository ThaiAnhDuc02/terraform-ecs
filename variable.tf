# Setup local variables
locals {
  region = "ap-southeast-1"
  author = "DUKE"
  network_root_name = "FCJ-network"
  vpc_cidr = "10.0.0.0/16"
  compute_root_name = "FCJ-compute"
  key_name = "FCJ-Lab-key"
  
  # RDS database
  db_username = "admin"
  db_password = "letmein12345"
  db_name = "fcjdb"
  
  # Cloud Map
  service_discovery_namespace_name = "fcjresbar.internal"
  service_discovery_service_name = "backend"
  
  # Load Balancer
  target_group_name = "my-tg"
  alb_name = "FCJ-alb"
  
  # Task definition of backend
  backend_family = "fcjresbar-task-be"
  backend_image = "730335321184.dkr.ecr.ap-southeast-1.amazonaws.com/backend-image"
  mysql_database = "fcjresbar"
  db_dialect = "mysql"
  be_port = "5000"
  jwt_secret = "0bac010eca699c25c8f62ba86e319c2305beb94641b859c32518cb854addb5f4"

  # Task definition of frontend
  frontend_family = "fcjresbar-task-fe"
  frontend_image = "730335321184.dkr.ecr.ap-southeast-1.amazonaws.com/frontend-image"
  be_host = "backend.fcjresbar.internal"
  

  ec2_instances = [
    {
      name               = "server_test"
      ami                = "ami-06650ca7ed78ff6fa"  # Ubuntu Server 24.04 LTS
      instance_type      = "t2.medium"
      subnet_id          = module.infrastructure_vpc.subnet_public1_id
      security_group_ids = [module.security.public_sg_id]
    },
  ]
}
