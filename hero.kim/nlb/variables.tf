variable "private_subnets" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID where the ALB is deployed"
  type        = string
}

variable "target_instance_ids" {
  description = "List of target instance IDs"
  type        = list(string)
}

variable "name" {
  description = "The name of the resource"
  default     = "94102108-TFT"
}