#### ---- Load the relevant *.hcl file based on where terragrunt was invoked ---- ####
locals {
  dev_vars = read_terragrunt_config(find_in_parent_folders("dev.hcl"))
}

#### ---- Indicate where to source the terraform module from --- ####
terraform {
  source  = "git::git@github.com:Hookae1/terraform_modules.git//modules/r53?ref=v1.0.7"
}

#### ---- Include block ---- ####
include "root" {
  path   = find_in_parent_folders()
  expose = true
  merge_strategy = "deep"
} 

#### ---- Dependency blocks ---- ####
dependency "ec2" {
  config_path  = "../ec2"
  skip_outputs = false

  mock_outputs_allowed_terraform_commands = ["init", "validate"]
  mock_outputs = {
    public_ip  = "127.0.0.1"
  }
}

#### ---- Indicate the input values to use for the variables of the module ---- ####
inputs = {
  ### Global variables
  env_id              = "${local.dev_vars.locals.env_id}"
  project_id          = "${local.dev_vars.locals.project_id}"
  region_id           = "${local.dev_vars.locals.region_id}"
  maintainer          = "${local.dev_vars.locals.maintainer}"

  ### This module new declared variables
  domain              = "grunt-test.pp.ua"    
  app_sub_domain      = "www"   
  api_sub_domain      = "api"

  ### Dependency from another modules
  public_ip           = dependency.ec2.outputs.public_ip
}



