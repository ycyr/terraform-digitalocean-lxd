
 resource "digitalocean_tag" "lxd" {
  name = "lxd"
}


data "template_file" "userdata_web" {
  template = "${file("script.sh.tpl")}"
  depends_on = ["random_string.password"]

  vars = {
    lxd_password  = "${random_string.password.result}"
    size = "${digitalocean_volume.lxd-volume.size}"
  }
}


resource "digitalocean_droplet" "lxd" {
   image              = "${var.ubuntu}"
   region             = "${var.region}"
   name = "lxd"
   size = "${var.size_vm}"
   #ssh_keys = ["${var.ssh_key_ID}", "${var.ssh_key_ID2}"]
   ssh_keys = ["${var.ssh_key_ID}"]
   tags   = ["${digitalocean_tag.lxd.id}"]
   user_data = "${data.template_file.userdata_web.rendered}"
    volume_ids = ["${digitalocean_volume.lxd-volume.id}"]
   provisioner "local-exec" {
       command = "echo ${digitalocean_droplet.lxd.ipv4_address} > publicip.txt"
    }

}

resource "digitalocean_volume" "lxd-volume" {
  region      = "${var.region}"
  name        = "lxd-volume"
  size        = "${var.size_volume}"
  description = "lxd volume"
}

resource "random_string" "password" {
  length = 16
  special = true
  provisioner "local-exec" {
    command = "echo \"${random_string.password.result}\" > password.txt"
  }
}

resource "digitalocean_firewall" "lxd" {
  name = "only-from-home"

  droplet_ids = ["${digitalocean_droplet.lxd.id}"]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "22"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "80"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "443"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]
   
 outbound_rule = [
   {
    protocol                = "udp"
    port_range              = "all"
    destination_addresses   = ["0.0.0.0/0", "::/0"]
  },
   {
    protocol                = "tcp"
    port_range              = "all"
    destination_addresses   = ["0.0.0.0/0", "::/0"]
  },
   {
    protocol                = "icmp"
    destination_addresses   = ["0.0.0.0/0", "::/0"]
  }
]
  
}
