#!/bin/bash
#apt update && apt upgrade -y
#apt install apt-transport-https curl containerd -y
#mkdir -p /etc/containerd
#containerd config default | tee /etc/containerd/config.toml > /dev/null
#sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
#systemctl restart containerd
#curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
#apt update
#apt install -y kubelet kubeadm kubectl
#apt-mark hold kubelet kubeadm kubectl
#modprobe overlay
#modprobe br_netfilter
#cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
#net.bridge.bridge-nf-call-iptables  = 1
#net.bridge.bridge-nf-call-ip6tables = 1
#net.ipv4.ip_forward                 = 1
#EOF
#sysctl --system
echo "
192.168.100.101 master
192.168.100.102 worker1
192.168.100.103 worker2" >> /etc/hosts
#reboot
