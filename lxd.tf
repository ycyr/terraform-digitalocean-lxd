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

   connection {
    type        = "ssh"
    private_key = "${file("${var.key_path}")}"
    user        = "root"
    timeout     = "2m"
    agent 	= "true"
  }


 provisioner "remote-exec" {
    script  = "script.sh"
}
}
