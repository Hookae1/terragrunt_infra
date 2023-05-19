# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {     
  region = var.region_id
  profile = "coax"
  default_tags {
    tags = {
      Terraform  = true
      Terragrunt = true
      Project    = var.project_id
      Contact    = var.maintainer
    }
  }
}
