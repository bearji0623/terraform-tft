# VPC variables
variable "vpc_cidr_block" {
    description = "VPC CIDR Block"
    type = string
}

variable "vpc_name" {
    description = "VPC NAME"
    type = string
}

# AZ
variable "az_a" {
    description = "ap-northeast-2a"
    type = string
}

variable "az_c" {
    description = "ap-northeast-2c"
    type = string
}

# PUBLIC SUBNET 
variable "public_a_subnet_cidr_block" {
    description = "PUBLIC SUBNET A CIDR Block"
    type = string
}

variable "public_a_subnet_name" {
    description = "PUBLIC SUBNET A Name"
    type = string
}

variable "public_c_subnet_cidr_block" {
    description = "PUBLIC SUBNET C CIDR Block"
    type = string 
}

variable "public_c_subnet_name" {
    description = "PUBLIC SUBNET C Name"
    type = string
}

# INTERNET GATEWAY 
variable "internet_gateway_name" {
    description = "Internet Gateway Name"
    type = string
}

# PRIVATE SUBNET 
## WEB
variable "web_private_a_subnet_name" {
    description = "WEB Private Subnet A Name"
    type = string
}

variable "web_private_a_subnet_cidr_block" {
    description = "WEB Private Subnet A CIDR Block"
    type = string
}

variable "web_private_c_subnet_name" {
    description = "WEB Private Subnet C Name"
    type = string
}

variable "web_private_c_subnet_cidr_block" {
    description = "WEB Private Subnet C CIDR Block"
    type = string
}

## WAS
variable "was_private_a_subnet_name" {
    description = "WAS Private Subnet A Name"
    type = string
}

variable "was_private_a_subnet_cidr_block" {
    description = "WAS Private Subnet A CIDR Block"
    type = string
}

variable "was_private_c_subnet_name" {
    description = "WAS Private Subnet C Name"
    type = string
}

variable "was_private_c_subnet_cidr_block" {
    description = "WAS Private Subnet C CIDR Block"
    type = string
}

## DB
variable "db_private_a_subnet_name" {
    description = "DB Private Subnet A Name"
    type = string
}

variable "db_private_a_subnet_cidr_block" {
    description = "DB Private Subnet A CIDR Block"
    type = string
}

variable "db_private_c_subnet_name" {
    description = "DB Private Subnet C Name"
    type = string
}

variable "db_private_c_subnet_cidr_block" {
    description = "DB Private Subnet C CIDR Block"
    type = string
}

# NAT GATEWAY
variable "nat_gateway_name" {
    description = "NAT Gateway Name"
    type = string
}

# ROUTE TABLE
variable "public_route_name" {
    description = "Public Route Table Name"
    type = string
}

variable "web_private_rt_name" {
    description = "WEB Private Route Table Name"
    type = string
}

variable "was_private_rt_name" {
    description = "WAS Private Route Table Name"
    type = string
}

variable "db_private_rt_name" {
    description = "DB Private Route Table Name"
    type = string
}




