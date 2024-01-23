#!/bin/bash

# Update the package list
apt update

# Upgrade installed packages
apt upgrade -y

# Install prerequisites for Ansible
apt install -y software-properties-common

# Add Ansible repository
apt-add-repository --yes --update ppa:ansible/ansible

# Install Ansible
apt install -y ansible

# install open ssh server
apt install -y openssh_server
