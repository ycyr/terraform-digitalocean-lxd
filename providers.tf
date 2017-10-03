provider "digitalocean" {
  token = "${var.do_token}"
  version = "~> v0.1.2"
}

provider "random" {
  version = "~> v1.0.0"
}

