#! /bin/bash

# This is a simple script that uses Certbot to install
# SSL certificates when serving web applications using 
# nginx

# Setup host

function setup_host() {
    printf "***************************************************\n\t\t Setting up host \n***************************************************\n"
    echo ======= Updating packages ========
    sudo apt-get update
    echo ======= Installing software properties common ========
    sudo apt-get install software-properties-common
    echo ======= Adding certbot Personal Package Archives ========
    sudo add-apt-repository ppa:certbot/certbot
    echo ======= Updating packages =======
    sudo apt-get update
}

function install_certbot() {
    printf "***************************************************\n\t\t Installing Certbot \n***************************************************\n"
    sudo apt-get install -y python-certbot-nginx 
}

function install_certificate() {
    printf "***************************************************\n\tInstalling SSL Certificate \n***************************************************\n"
    echo "====== Ensuring that nginx is running ======="
    sudo service nginx status
    echo "======= Installing SSL for nginx ======="
    sudo certbot --nginx
}

######################################################################
########################      RUNTIME       ##########################
######################################################################
setup_host
install_certbot
install_certificate
