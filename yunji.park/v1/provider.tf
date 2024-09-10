terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.61.0"
        }
    }
}

provider "aws" {
    region = "ap-northeast-2"

    default_tags {
        tags = {
            Owner = "94102178"
        }
    }
}
