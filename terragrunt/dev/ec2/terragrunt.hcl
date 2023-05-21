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

  mock_outputs = {
    public_subnets = "pubsub_grunt"
    vpc_id         = "vpc_grunt"
  }
}

dependency "sg" {
  config_path  = "../sg"
  skip_outputs = false

  mock_outputs_allowed_terraform_commands = ["init", "validate"]
  mock_outputs = {
    sg_ssh   = "sg_ssh_grunt"
    sg_web   = "sg_web_grunt"
    sg_mon   = "sg_ssh_grunt"
    sg_data  = "sg_data_grunt"
  }
}

dependency "iam" {
  config_path  = "../iam"
  skip_outputs = true
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
  ec2_public_ssh_key  = "${local.dev_vars.locals.ec2_public_ssh_key}"
  app_name            = "test"
  ec2_default_ami     = "ami-01cace73230891f68"

  ### This module inhertied variables from another moduels
  public_subnets          = dependency.vpc.outputs.public_subnets
  vpc_id                  = dependency.vpc.outputs.vpc_id
  vpc_security_group_ids  = [dependency.sg.outputs.sg_ssh, dependency.sg.outputs.sg_web, dependency.sg.outputs.sg_mon, dependency.sg.outputs.sg_data]  

}





