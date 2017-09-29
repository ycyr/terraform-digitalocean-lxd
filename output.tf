output "public_address" {
  value = ["${digitalocean_droplet.lxd.*.ipv4_address}"]
}

output "lxd_password" { 
  value = ["${random_string.password.result}"]
  sensitive = true
} 


