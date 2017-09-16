provider "digitalocean" {
  token = "${var.do_token}"
  version = "~> v0.1.2"
}

resource "digitalocean_tag" "lxd" {
  name = "lxd"
}


resource "digitalocean_droplet" "lxd" {
   image              = "${var.ubuntu}"
   region             = "${var.region}"
   name = "lxd-1"
   size = "512mb"
   ssh_keys = ["${var.ssh_key_ID}", "${var.ssh_key_ID2}"]
   tags   = ["${digitalocean_tag.lxd.id}"]
   user_data = "${file("script.sh")}"

}
