module "infrastructure_vpc" {
  source = "./modules/infrastructure_vpc" # Đường dẫn đến module hạ tầng
  
  # Input
  region = local.region
  vpc_cidr = local.vpc_cidr
  network_root_name = local.network_root_name
  author = local.author
}

module "security" {
  source = "./modules/security_group"

  # Input
  region = local.region
  author = local.author
  network_root_name = local.network_root_name
  vpc_id = module.infrastructure_vpc.vpc_id
}

module "compute" {
  source = "./modules/compute"

  # Input
  region             = local.region
  key_name           = local.key_name
  author             = local.author
  compute_root_name  = local.compute_root_name
  ec2_instances      = local.ec2_instances
  network_root_name = local.network_root_name
}

module "rds" {
  source = "./modules/rds"

  # Input
  region = local.region
  author = local.author
  compute_root_name = local.compute_root_name
  db_username = local.db_username
  db_password = local.db_password
  db_name = local.db_name
  subnet_private1_id = module.infrastructure_vpc.subnet_private1_id
  subnet_private2_id = module.infrastructure_vpc.subnet_private2_id
  security_group_ids = [ module.security.db_sg_id ]
}

module "cloud_map" {
  source = "./modules/cloud-map"

  # Input
  region = local.region
  author = local.author
  vpc_id = module.infrastructure_vpc.vpc_id
  service_discovery_namespace_name = local.service_discovery_namespace_name
  service_discovery_service_name = local.service_discovery_service_name
}

module "alb" {
  source = "./modules/alb"

  # Input
  region = local.region
  author = local.author
  vpc_id = module.infrastructure_vpc.vpc_id
  security_group_id = module.security.public_sg_id
  subnet_ids         = [module.infrastructure_vpc.subnet_public1_id, module.infrastructure_vpc.subnet_public2_id]  # Truyền vào hai subnet
  target_group_name = local.target_group_name
  alb_name = local.alb_name
}

module "ecs" {
  source = "./modules/ecs"

  # Input
  region = local.region
  author = local.author

  backend_family = local.backend_family
  backend_image = local.backend_image
  db_username = local.db_username
  db_password = local.db_password
  mysql_database = local.mysql_database
  db_host = module.rds.db_instance_endpoint
  db_dialect = local.db_dialect
  be_port = local.be_port
  jwt_secret = local.jwt_secret

  frontend_family = local.frontend_family
  frontend_image = local.frontend_image
  be_host = local.be_host
  ecs_execution_role_arn = module.role.ecs_execution_role_arn
}

module "role" {
  source = "./modules/role"
  # Input
  region = local.region
  author = local.author
  network_root_name = local.network_root_name
}