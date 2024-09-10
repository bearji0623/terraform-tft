variable "vpc_name" {
  description = "CIDR block for the VPC"
  default     = "94102108-TFT"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.10.0.0/20"
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  default     = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "public_subnets" {
  description = "CIDR blocks for the public subnets"
  default     = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for the private subnets"
  default     = ["10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24", "10.10.7.0/24", "10.10.8.0/24"]
}
