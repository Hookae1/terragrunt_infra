locals {
  # Automatically load project-level variables
  project_vars  = read_terragrunt_config(find_in_parent_folders("project.hcl"))
  dev_vars      = read_terragrunt_config(find_in_parent_folders("dev/dev.hcl"))

  aws_profile   = local.project_vars.locals.aws_profile_name
  region_id     = local.project_vars.locals.region_id
  project_id    = local.project_vars.locals.project_id
  maintainer    = local.project_vars.locals.maintainer

  env_id        = local.dev_vars.locals.env_id

}

terraform {
  extra_arguments "aws_profile" {
    commands = [
      "init",
      "apply",
      "refresh",
      "import",
      "plan",
      "taint",
      "untaint"
    ]

    env_vars = {
      AWS_PROFILE = "${local.aws_profile}"
    }
  }
}

#### ---- Setup remote state in S3 & DynamoDB ---- ####
remote_state {
  backend = "s3"
  config = {
    bucket         = "grunt-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region_id}"
    encrypt        = true
    dynamodb_table = "${local.project_id}-tfstate-lock"
    profile        = "${local.aws_profile}"
    
  }
}

#### ---- Setup provider.tf for modules ---- ####
generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region                   = "${local.region_id}"  
  profile                  = "${local.aws_profile}"
  default_tags {
    tags = {
      Env         = "${local.env_id}"
      ProjectId   = "${local.project_id}"
      Contact     = "${local.maintainer}"
      Terraform   = "true"
      Terragrunt  = "true"
    }
  }
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"
  default_tags {
    tags = {
      Env         = "${local.env_id}"
      ProjectId   = "${local.project_id}"
      Contact     = "${local.maintainer}"
      Terraform   = "true"
      Terragrunt  = "true"
    }
  }
}
EOF
}

#### ---- Setup backend.tf for modules ---- ####

generate "backend" {
  path = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "${local.project_id}-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.region_id}"
    encrypt        = true       
    profile        = "${local.aws_profile}"
    dynamodb_table = "${local.project_id}-tfstate-lock"
  }
}
EOF
}
