output "public_address" {
  value = ["${digitalocean_droplet.lxd.*.ipv4_address}"]
}
