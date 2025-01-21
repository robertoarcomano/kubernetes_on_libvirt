#!/bin/bash
rm ./provision/.ssh -rf
mkdir -p ./provision/.ssh
chmod 700 ./provision/.ssh
ssh-keygen -t rsa -b 4096 -N "" -f ./provision/.ssh/id_rsa
cp ./provision/.ssh/id_rsa.pub ./provision/.ssh/authorized_keys
