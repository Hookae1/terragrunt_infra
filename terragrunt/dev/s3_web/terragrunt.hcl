#### ---- Load the relevant *.hcl file based on where terragrunt was invoked ---- ####
locals {
  dev_vars = read_terragrunt_config(find_in_parent_folders("dev.hcl"))
}

#### ---- Indicate where to source the terraform module from --- ####
terraform {
  source  = "git::git@github.com:Hookae1/terraform_modules.git//modules/s3_web?ref=v1.0.6"
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
}

dependency "r53" {
  config_path  = "../r53"
  skip_outputs = false
}

#### ---- Indicate the input values to use for the variables of the module ---- ####
inputs = {
  ### Generall variables
  env_id              = "${local.dev_vars.locals.env_id}"
  project_id          = "${local.dev_vars.locals.project_id}"
  region_id           = "${local.dev_vars.locals.region_id}"
  maintainer          = "${local.dev_vars.locals.maintainer}"

  ### This module new declared/overwrited variables


  ### This module inhertied variables from another moduels
  app_domain          = dependency.r53.outputs.app_domain
  api_domain          = dependency.r53.outputs.api_domain
  acm_certificate_arn = dependency.r53.outputs.acm_certificate_arn

}



