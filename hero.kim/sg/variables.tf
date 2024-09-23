variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "bastion_cidr" {
  description = "CIDR blocks for Bastion SSH access"
  type        = list(string)
  default     = ["27.122.140.10/32", "165.243.5.20/32"]
}

variable "web_ip" {
  description = "IP address of the WAS instance"
  type        = string
}

variable "web1_ip" {
  description = "IP address of the second WAS instance"
  type        = string
}

variable "name" {
  description = "The name of the resource"
  default     = "94102108-laC-TFT"
}