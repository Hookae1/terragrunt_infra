#### ---- Load the relevant *.hcl file based on where terragrunt was invoked ---- ####
locals {
  dev_vars = read_terragrunt_config(find_in_parent_folders("dev.hcl"))
}

#### ---- Indicate where to source the terraform module from --- ####
terraform {
  source  = "git::git@github.com:Hookae1/terraform_modules.git//modules/s3_web?ref=v1.0.7"
}

#### ---- Include block ---- ####
include "root" {
  path   = find_in_parent_folders()
  expose = true
  merge_strategy = "deep"
} 

#### ---- Dependency blocks ---- ####
dependency "s3_etc" {
  config_path  = "../s3_etc"
  skip_outputs = false

  mock_outputs_allowed_terraform_commands = ["init", "validate"]
  mock_outputs = {
    s3_logs = "s3_logs"
  }

}

dependency "r53" {
  config_path  = "../r53"
  skip_outputs = false

  mock_outputs_allowed_terraform_commands = ["init", "validate"]
  mock_outputs = {
    acm_certificate_arn = "arn:aws:us-east-1:738668486270:certificate/2ksl-dsfsd890-fsfs"
  }

}

#### ---- Indicate the input values to use for the variables of the module ---- ####
inputs = {
  ### Generall variables
  env_id              = "${local.dev_vars.locals.env_id}"
  project_id          = "${local.dev_vars.locals.project_id}"
  region_id           = "${local.dev_vars.locals.region_id}"
  maintainer          = "${local.dev_vars.locals.maintainer}"

  ### This module new declared/overwrited variables
  app_domain         = "www.grunt-test.pp.ua"
  api_domain         = "api.grunt-test.pp.ua"

  ### This module inhertied variables from another moduels
  acm_certificate_arn = dependency.r53.outputs.acm_certificate_arn
  s3_logs             = dependency.s3_etc.outputs.s3_logs

}



