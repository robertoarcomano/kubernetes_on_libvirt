#!/bin/bash
./create_key.sh
date > log
vagrant up >> log 2>&1

# Install kubeconfig
vagrant ssh master -c "sudo cat /etc/kubernetes/admin.conf" | sed 's|server: https://[^:]*:6443|server: https://master:6443|' > kubeconfig
cp kubeconfig ~/.kube/config

# Use helm
./helm.sh

date >> log

