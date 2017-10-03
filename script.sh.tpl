#!/bin/bash
add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
apt update -y      
apt install  -y lxd zfsutils-linux vim htop screen unzip
DEBIAN_FRONTEND=noninteractive apt upgrade -y 
service lxd restart
lxc network create lxdbr0 ipv6.address=none ipv4.address=172.22.3.1/24 ipv4.nat=true
lxc network attach-profile lxdbr0 default eth0
lxd init --auto --storage-backend zfs --storage-pool lxd --storage-create-device=/dev/sda ${size} 
sysctl -w vm.max_map_count=262144
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
lxc config set core.https_address ":8443"
lxc config set core.trust_password "${lxd_password}"
curl -fsSL get.docker.com -o get-docker.sh ; sh get-docker.sh
curl  -fsSL https://releases.hashicorp.com/packer/1.1.0/packer_1.1.0_linux_amd64.zip -o packer.zip
curl  -fsSL https://releases.hashicorp.com/terraform/0.10.7/terraform_0.10.7_linux_amd64.zip -o terraform.zip
unzip packer.zip -d /usr/local/bin/
unzip terraform.zip -d /usr/local/bin/
rm -fv *.zip *.sh
systemctl disable docker
systemctl stop docker
reboot
