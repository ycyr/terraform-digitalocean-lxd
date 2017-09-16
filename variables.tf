variable "do_token" {}

variable "key_path" {}

variable "ssh_key_ID" {}

variable "ssh_key_ID2" {}

variable "region" {}


# Default OS

variable "ubuntu" {
  description = "Default Ubuntu"
  default     = "ubuntu-17-04-x64"
}

variable "centos" {
  description = "Default Centos"
  default     = "centos-73-x64"
}

