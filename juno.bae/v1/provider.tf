provider "aws" {
  default_tags {
    tags = {
      Owner = "94102047"
    }
  }
  region = var.region
}
