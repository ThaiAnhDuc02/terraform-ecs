variable "region" {
  description = "Region name of infrastructure"
  type = string
}

variable "author" {
  description = "Creator of this resource"
  type = string
}

variable "compute_root_name" {
  description = "Root name of Compute services"
  type = string
}

variable "db_username" {
  description = "Master user of Database"
  type = string
}

variable "db_password" {
  description = "Passowrd of Database Master User"
  type = string
}

variable "db_name" {
  description = "Name of Database"
  type = string
}

variable "subnet_private1_id" {
  description = "Id of Private Subnet 1"
  type = string
}
variable "subnet_private2_id" {
  description = "Id of Private Subnet 2"
  type = string
}

variable "security_group_ids" {
  description = "List of SG Ids"
  type = set(string)
}