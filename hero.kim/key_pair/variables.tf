variable "key_name" {
  description = "The name of the key pair"
  default     = "tt"
}

variable "public_key_path" {
  description = "Path to the public key file"
  default     = "./key_pair/tt.pub"
}
