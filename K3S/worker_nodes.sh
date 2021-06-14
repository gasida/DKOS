#!/usr/bin/env bash
MASTER_IP=192.168.200.10
HOSTNAME=$(cat /etc/hostname)

# config for work_nodes only
apt-get install sshpass -y
sshpass -p "qwe123" scp -o StrictHostKeyChecking=no root@$MASTER_IP:/var/lib/rancher/k3s/server/node-token /root
NODE_TOKEN=$(cat /root/node-token)
curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$NODE_TOKEN INSTALL_K3S_EXEC="--node-name $HOSTNAME --docker" sh -s -