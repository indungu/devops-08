#! /bin/bash

# A simple script to automatically deploy the Yummy Recipes
# REACT Frontend App to an Amazon EC2 Ubuntu 16.04 instance

function initialize_worker() {
    printf "***************************************************\n\t\t
    Setting up host 
    \n***************************************************\n"
    # Update packages
    echo ======= Updating packages ========
    sudo apt-get update

    # Export language locale settings
    echo ======= Exporting language locale settings =======
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

    # Install NodeJS and NPM
    echo ======= Installing NodeJS =======
    cd ~
    sudo curl -sL https://deb.nodesource.com/setup_8.11.0 | bash
    sudo apt-get install -y nodejs
    node --version # Ensure NodeJS is installed
    npm --version # Ensure Node Package Manager CLI tool is installed as well
}

function clone_app_repository() {
    printf "***************************************************\n\t\t
    Fetching App 
    \n***************************************************\n"
    # Clone and access project directory
    echo ======== Cloning and accessing project directory ========
    if [[ -d ~/yummy-rest ]]; then
        sudo rm -rf ~/yummy-react
    else
        git clone -b develop https://github.com/indungu/yummy-react.git ~/yummy-react
        cd ~/yummy-react/
    fi
}

function setup_app() {
    printf "***************************************************\n
        Installing App dependencies and Env Variables 
    \n***************************************************\n"
    # Install required packages
    echo ======= Installing required packages ========
    curl -o- -L https://yarnpkg.com/install.sh | bash # Installing yarn package manager
    yarn install
    echo ======= Creating production build ========
    yarn build production
}

# Install and configure nginx
function setup_nginx() {
    printf "***************************************************\n\t\t
    Setting up nginx 
    \n***************************************************\n"
    echo ======= Installing nginx =======
    sudo apt-get install -y nginx

    # Configure nginx routing
    echo ======= Configuring nginx =======
    echo ======= Removing default config =======
    sudo rm -rf /etc/nginx/sites-available/default
    sudo rm -rf /etc/nginx/sites-enabled/default
    echo ======= Replace config file =======
    sudo bash -c 'cat > /etc/nginx/sites-available/yummyreact <<EOF
    server {
            listen 80 default_server;
            listen [::]:80 default_server;

            server_name _;

            location / {
                    # reverse proxy and serve the app
                    # running on the localhost:3000
                    proxy_pass http://127.0.0.1:3000/;
                    proxy_set_header HOST \$host;
                    proxy_set_header X-Forwarded-Proto \$scheme;
                    proxy_set_header X-Real-IP \$remote_addr;
                    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            }
    }
    EOF'

    echo ======= Create a symbolic link of the file to sites-enabled =======
    sudo ln -s /etc/nginx/sites-available/yummyreact /etc/nginx/sites-enabled/

    # Ensure nginx server is running
    echo ====== Checking nginx server status ========
    sudo systemctl restart nginx
    sudo nginx -t
}

# Serve the web app through gunicorn
function serve_app() {
    printf "***************************************************\n\t\tServing the App \n***************************************************\n"
    yarn add global serve # Add serving package
    serve ---silent --port 3000 build
}

######################################################################
########################      RUNTIME       ##########################
######################################################################

initialize_worker
clone_app_repository
setup_app
setup_nginx
serve_app