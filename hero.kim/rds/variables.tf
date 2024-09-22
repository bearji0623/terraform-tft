variable "identifier" {
  description = "Name for an automatically created database on cluster creation"
  type        = string
  default     = "db"
}

variable "engine" {
  description = "The name of the database engine to be used for this DB cluster"
  type        = string
  default     = "mysql"
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = string
  default     = "3306"
}

variable "engine_version" {
  description = "The database engine version"
  type        = string
  default     = "5.7.44"
}

variable "instance_class" {
  description = "Instance type to use at master instance"
  type        = string
  default     = "db.t3.medium"
}

variable "allocated_storage" {
  description = "Allocated storage to use at master instance"
  type        = string
  default     = "20"
}

variable "db_name" {
  description = "Database name to use at master instance"
  type        = string
  default     = "db"
}

variable "user_name" {
  description = "User name to use at master instance"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Password to use at master instance"
  type        = string
  default     = "a123456789"
}

variable "db_subnet_group_name" {
  description = "The name of the subnet group name"
  type        = string
  default     = "lac-tft-db-sg"
}

variable "private_subnets" {
  description = "The list of private subnets to be used for the RDS or Aurora DB subnet group"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "The ID of the RDS security group"
  type        = string
}