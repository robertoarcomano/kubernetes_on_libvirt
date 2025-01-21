#!/bin/bash
kubeadm init --pod-network-cidr=10.244.0.0/16 > /tmp/output.txt
grep "kubeadm join" -A1 /tmp/output.txt > /tmp/join-command.sh
chmod +x /tmp/join-command.sh
ssh-keyscan worker1 >> /home/vagrant/.ssh/known_hosts
ssh-keyscan worker2 >> /home/vagrant/.ssh/known_hosts
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
su vagrant -c "scp /tmp/join-command.sh worker1:/tmp/"
su vagrant -c "ssh worker1 -i /home/vagrant/.ssh/id_rsa sudo /tmp/join-command.sh"
su vagrant -c "scp /tmp/join-command.sh worker2:/tmp/"
su vagrant -c "ssh worker2 -i /home/vagrant/.ssh/id_rsa sudo /tmp/join-command.sh"
