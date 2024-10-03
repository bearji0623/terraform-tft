variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
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