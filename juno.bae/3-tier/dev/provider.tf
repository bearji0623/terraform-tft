provider "aws" {
  region = "ap-northeast-2"
  
  default_tags {
    tags = {
      Owner = "94102047"
      Project = "JUNO"
      Environment = "DEV"
      
    }
  }
}
