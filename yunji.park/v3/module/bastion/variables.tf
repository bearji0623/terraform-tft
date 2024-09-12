variable "ami" {
    description = "AMI - Amazon Linux 2"
    type = string
}

variable "type" {
    description = "Instance Type"
    type = string
}

variable "bastion_name" {
    description = "Bastion Server Name"
    type = string
}

variable "enable_public_ip" {
    description = "Public IP Enabled"
    type = bool
}

variable "root_name" {
    description = "Root Volume Name Tag"
    type = string
}

variable "root_size" {
    description = "Root Volume Size"
    type = number
}

variable "root_type" {
    description = "Root Volume Type"
    type = string
}

variable "root_delete_option" {
    description = "Delete when EC2 Terminate"
    type = bool
}