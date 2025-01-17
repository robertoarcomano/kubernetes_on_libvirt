#!/bin/bash
kubeadm init --pod-network-cidr=10.244.0.0/16 > /tmp/output.txt
grep "kubeadm join" -A1 /tmp/output.txt > /tmp/join-command.sh
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
