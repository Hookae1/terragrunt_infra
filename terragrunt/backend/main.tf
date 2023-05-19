   module "terraform_state_backend" {
     source = "cloudposse/tfstate-backend/aws"

     name       = "grunt"
     attributes = ["tfstate"]

     terraform_backend_config_file_path = "."
     terraform_backend_config_file_name = "backend.tf"
     force_destroy                      = false
   }