#!/usr/bin/env bash

# bashrc settting
echo "sudo su -" >> .bashrc

# root password
printf "qwe123\nqwe123\n" | passwd

# ssh-config
sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
systemctl restart sshd

# tools update
apt update
apt-get install bridge-utils net-tools jq tree git -y

# apparmor disable
systemctl stop apparmor && systemctl disable apparmor

# docker install
curl -fsSL https://get.docker.com | sh

# local dns - hosts file
echo "192.168.200.10 k3s-m" >> /etc/hosts
for (( i=1; i<=$1; i++  )); do echo "192.168.200.10$i k3s-w$i" >> /etc/hosts; done