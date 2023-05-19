### =================================== ###
###          General variables          ###
### =================================== ###
variable "region_id" {
  description = "Region"
  type        = string
  default     = "eu-west-2"
}

variable "env_id" {
  description = "Uniqe Id of the environtment used for names and tags"
  type        = string
  default     = "dev"
}

variable "project_id" {
  description = "Uniqe Id of the project used for names and tags"
  type        = string
  default     = "grunt"
}

variable "maintainer" {
  description = "Email of Person Responsible for Project Infrastructure"
  type        = string
  default     = "yurii.rybitskyi@coaxsoft.com"
}

### =================================== ###
###     Specific variable for module    ###
### =================================== ###

