provider "aws" {
  default_tags {
    tags = {
      Owner = "94102047"
      Project = var.project
      Environment = var.env
    }
  }
  region = "ap-northeast-2"
}
