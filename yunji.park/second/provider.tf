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
    access_key = "AKIAZI2LFIB3YLJAL4WP"
    secret_key = "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"
    profile = "default"

    default_tags {
        tags = {
            Owner = "94102178"
        }
    }
}
