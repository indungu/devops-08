#! /bin/bash

# A simple script to install ansible on the AMI
# Ansible shall the  be used for further provisioning

install_ansible() {
    printf "*********************************************\n\t\t Installing Ansible\n*********************************************\n"
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y ansible
}

# Run command
install_ansible
