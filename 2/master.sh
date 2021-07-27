#!/usr/bin/env bash

# init kubernetes 
kubeadm init --token 123456.1234567890123456 --token-ttl 0 --pod-network-cidr=172.16.0.0/16 --apiserver-advertise-address=192.168.100.10

# config for master node only 
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# calico install
curl -O https://docs.projectcalico.org/manifests/calico.yaml
kubectl apply -f calico.yaml

# calicoctl install
curl -o kubectl-calico -O -L  "https://github.com/projectcalico/calicoctl/releases/download/v3.19.1/calicoctl"
chmod +x kubectl-calico
mv kubectl-calico /usr/bin
cp /usr/bin/kubectl-calico /usr/bin/calicoctl

# etcdctl install
apt install etcd-client -y

# source bash-completion for kubectl kubeadm
source <(kubectl completion bash)
source <(kubeadm completion bash)

## Source the completion script in your ~/.bashrc file
echo 'source <(kubectl completion bash)' >>~/.bashrc 
echo 'source <(kubeadm completion bash)' >>~/.bashrc

## alias kubectl to k 
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc

## kubectx kubens install
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx

## kube-ps1 install
git clone https://github.com/jonmosco/kube-ps1.git /root/kube-ps1
echo "source /root/kube-ps1/kube-ps1.sh" >> ~/.bashrc
echo "KUBE_PS1_SYMBOL_ENABLE=false" >> ~/.bashrc
echo "PS1='[\u@\h:\w \$(kube_ps1)]\$ '" >> ~/.bashrc
sed -i "s/kubernetes-admin@kubernetes/ctx-k8s/g" ~/.kube/config