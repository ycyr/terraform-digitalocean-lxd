variable "do_token" {}

#variable "key_path" {}

variable "ssh_key_ID" {}

#variable "ssh_key_ID2" {}

variable "region" {
  default = "nyc3"

}

variable "size_vm" {
  default = "512mb"
}

variable "size_volume" {
  default = 30
}

variable "ubuntu" {
  description = "Default Ubuntu"
  default     = "ubuntu-17-04-x64"
}

