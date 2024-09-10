variable "region" {
  description = "The AWS region to Infra resources"
  default     = "ap-northeast-2"
}

variable "public_key_path" {
  description = "Path to the public key file"
  default     = "trio.pub"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  default     = "ami-00ff737803101edd1"
}

variable "instance_type_bastion" {
  description = "Instance type for the Bastion host"
  default     = "t2.micro"
}

variable "instance_type_was" {
  description = "Instance type for the WAS host"
  default     = "t3.medium"
}

#################################

