#!/bin/bash
./create_key.sh
date > log
vagrant up >> log 2>&1
date >> log

