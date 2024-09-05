variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "bastion_cidr" {
  description = "CIDR blocks for Bastion SSH access"
  type        = list(string)
  default     = ["27.122.140.10/32", "165.243.5.20/32"]
}
