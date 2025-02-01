#!/bin/bash
apt update && apt upgrade -y
apt install apt-transport-https curl containerd -y
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml > /dev/null
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
systemctl restart containerd
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
modprobe overlay
modprobe br_netfilter
cat <<EOF | sudo tee /etc/modules-load.d/k8s_modules.conf
br_netfilter
overlay
EOF
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sysctl --system

NUM_WORKERS=$1
BASE_IP="192.168.100."

# Aggiungi la riga per il master
echo "${BASE_IP}101 master" | sudo tee -a /etc/hosts

# Aggiungi le righe per i worker
for i in $(seq 1 $NUM_WORKERS); do
    echo "${BASE_IP}$((101 + i)) worker${i}" | sudo tee -a /etc/hosts
done
#reboot
