#!/bin/bash
rm ./provision/.ssh -rf
mkdir ./provision/.ssh
chmod 700 ./provision/.ssh
ssh-keygen -t rsa -b 4096 -N "" -f ./provision/.ssh/id_rsa
cp ./provision/.ssh/id_rsa.pub ./.ssh/authorized_keys
cp ./provision/.ssh/id_rsa.pub ./.ssh/authorized_keys2
