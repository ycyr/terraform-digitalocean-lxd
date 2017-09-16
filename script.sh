#!/bin/bash
add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
apt update -y      
apt install  -y lxd zfsutils-linux vim htop screen
apt update -y    
DEBIAN_FRONTEND=noninteractive apt upgrade -y 
service lxd restart
lxc network create lxdbr0 ipv6.address=none ipv4.address=172.22.3.1/24 ipv4.nat=true
lxc network attach-profile lxdbr0 default eth0
lxd init --auto --storage-backend zfs  --storage-pool lxd --storage-create-loop 15
sysctl -w vm.max_map_count=262144
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
