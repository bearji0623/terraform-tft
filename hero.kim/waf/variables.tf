variable "name" {
  description = "The name of the Resource"
  default     = "94102108-laC-TFT"
}

variable "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  type        = string
}