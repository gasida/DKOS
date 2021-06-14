#!/usr/bin/env bash
MASTER_IP=192.168.200.10
HOSTNAME=$(cat /etc/hostname)

# install k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--advertise-address $MASTER_IP --disable-cloud-controller --node-name $HOSTNAME --docker" sh -s -

# source bash-completion for kubectl kubeadm
source <(kubectl completion bash)

## Source the completion script in your ~/.bashrc file
echo 'source <(kubectl completion bash)' >>~/.bashrc 

# alias kubectl to k 
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc