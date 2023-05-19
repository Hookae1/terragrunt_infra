#### ---- Load the relevant *.hcl file based on where terragrunt was invoked ---- ####
locals {
  dev_vars = read_terragrunt_config(find_in_parent_folders("dev.hcl"))
}

#### ---- Indicate where to source the terraform module from --- ####
terraform {
  source  = "git::git@github.com:Hookae1/terraform_modules.git//modules/ec2?ref=v1.0.6"
}

#### ---- Include block ---- ####
include "root" {
  path   = find_in_parent_folders()
  expose = true
  merge_strategy = "deep"
} 

#### ---- Dependency blocks ---- ####
dependency "vpc" {
  config_path  = "../vpc"
  skip_outputs = false
}

dependency "sg" {
  config_path  = "../sg"
  skip_outputs = false
}

dependency "iam" {
  config_path  = "../iam"
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
  ec2_instance_type   = "${local.dev_vars.locals.ec2_instance_type}"
  ec2_public_ssh_key  = "${local.dev_vars.locals.ec2_public_ssh_key}"м
  app_name            = "test"
  ec2_default_ami     = "ami-01cace73230891f68"

  ### This module inhertied variables from another moduels
  subnet_id               = dependency.vpc.outputs.public_subnets
  vpc_security_group_ids  = [dependency.sg.outputs.sg_ssh.id, dependency.sg.outputs.sg_web.id, dependency.sg.outputs.mon.id, dependency.sg.outputs.data.id]  



}





