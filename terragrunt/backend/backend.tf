terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    region         = "eu-west-2"
    bucket         = "grunt-tfstate"
    key            = "terraform.tfstate"
    dynamodb_table = "grunt-tfstate-lock"
    profile        = ""
    role_arn       = ""
    encrypt        = "true"
  }
}
