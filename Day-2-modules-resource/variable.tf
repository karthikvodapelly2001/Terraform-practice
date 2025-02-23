variable "type" {

  type    = string
  default = ""

}
variable "key" {
  type    = string
  default = ""

}
variable "ami" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

