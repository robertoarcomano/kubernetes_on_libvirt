#!/bin/bash
./create_key.sh
date > log
vagrant up >> log 2>&1
vagrant ssh master -c "sudo cat /etc/kubernetes/admin.conf" | sed 's|server: https://[^:]*:6443|server: https://master:6443|' > kubeconfig
date >> log

