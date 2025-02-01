#!/bin/bash
NUM_WORKERS=$1
kubeadm init --pod-network-cidr=10.244.0.0/16 > /tmp/output.txt
grep "kubeadm join" -A1 /tmp/output.txt > /tmp/join-command.sh
chmod +x /tmp/join-command.sh
for i in $(seq 1 $NUM_WORKERS); do
  ssh-keyscan "worker$i" >> /home/vagrant/.ssh/known_hosts
done
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
for i in $(seq 1 $NUM_WORKERS); do
  # Copia il comando di join
  su vagrant -c "scp /tmp/join-command.sh worker$i:/tmp/"

  # Esegui il comando di join sui worker
  su vagrant -c "ssh worker$i -i /home/vagrant/.ssh/id_rsa sudo /tmp/join-command.sh"
done
