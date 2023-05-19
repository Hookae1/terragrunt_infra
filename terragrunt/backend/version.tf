terraform {
  required_version = "1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0" #s3 module prevents update to
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.1.0"
    }
  }
}
