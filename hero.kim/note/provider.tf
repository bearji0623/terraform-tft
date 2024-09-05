terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.57.0"
    }
  }
}
provider "aws" {
  region = "ap-northeast-2"
  alias  = "seoul"
}