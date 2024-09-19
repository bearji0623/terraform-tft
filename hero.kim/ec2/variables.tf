variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  default     = "ami-00ff737803101edd1"
}

variable "instance_type_bastion" {
  description = "Instance type for the Bastion host"
  default     = "t2.micro"
}

variable "instance_type_web" {
  description = "Instance type for the Bastion host"
  default     = "t2.micro"
}

variable "instance_type_was" {
  description = "Instance type for the WAS host"
  default     = "t3.medium"
}

variable "key_name" {
  description = "The name of the key pair"
  default     = "tt"  
}

variable "aws_region" {
  description = "The AWS region"
  default     = "ap-northeast-2"
}

variable "public_subnets" {
  description = "Public subnets for the EC2 instances"
}

variable "private_subnets" {
  description = "Private subnets for the EC2 instances"
}

variable "bastion_sg_id" {
  description = "Security group ID for Bastion"
}

variable "web_sg_id" {
  description = "Security group ID for WEB"
}

variable "nlb_dns_name" {
  description = "The DNS name of the Network Load Balancer"
  type        = string
}
