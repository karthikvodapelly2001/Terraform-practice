variable "engine_options" {
  type    = string
  default = ""
}

variable "engine_version" {
  type    = string
  default = ""
}

variable "DB_instance_identifier" {
  type    = string
  default = ""
}

variable "username" {
  type    = string
  default = ""
}

variable "password" {
  type    = string
  default = ""
}

variable "DB_instance_class" {
  type    = string
  default = ""
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "VPC" {
  type    = string
  default = ""
}

variable "subnet_group" {
  type    = string
  default = ""
}

variable "VPC_sg" {
  type    = list(string)
  default = []
}

variable "AZ" {
  type    = string
  default = ""
}
