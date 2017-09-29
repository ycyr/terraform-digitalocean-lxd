provider "digitalocean" {
  token = "${var.do_token}"
  version = "~> v0.1.2"
}

provider "random" {
  version = "~> v1.0.0"
}


/* resource "digitalocean_tag" "lxd" {
  name = "lxd"
}

*/
data "template_file" "userdata_web" {
  template = "${file("script.sh.tpl")}"
  depends_on = ["random_string.password"]

  vars = {
    lxd_password  = "${random_string.password.result}"
  }
}


resource "digitalocean_droplet" "lxd" {
   image              = "${var.ubuntu}"
   region             = "${var.region}"
   name = "lxd-1"
   size = "2gb"
#   size = "512mb"
   ssh_keys = ["${var.ssh_key_ID}", "${var.ssh_key_ID2}"]
 #  tags   = ["${digitalocean_tag.lxd.id}"]
   user_data = "${data.template_file.userdata_web.rendered}"
  provisioner "local-exec" {
    command = "echo ${digitalocean_droplet.lxd.ipv4_address} > publicip.txt"
  }

}

resource "random_string" "password" {
  length = 16
  special = true
  provisioner "local-exec" {
    command = "echo \"${random_string.password.result}\" > password.txt"
  }
}

