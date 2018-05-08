#! /bin/bash

# Update packages
echo ======= Updating packages ========
sudo apt-get update

# Export language locale settings
echo ======= Exporting language locale settings =======
export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# Install pip3
echo ======= Installing pip3 =======
sudo apt-get install -y python3-pip

# Install virtualenv
echo ======= Installing virtualenv =======
pip3 install virtualenv

# Create virtual environment and activate it
echo ======== Creating and activating virtual env =======
virtualenv venv
source ./venv/bin/activate

# Clone and access project directory
echo ======== Cloning and accessing project directory ========
git clone -b develop https://github.com/indungu/yummy-rest.git project
cd project/

# Install required packages
echo ======= Installing required packages ========
pip install -r requirements.txt

# Export required environment variable
echo ======= Exporting the necessary environment variables ========
export DATABASE_URL="postgres://budufkitteymek:095f0029056c313190744c68ca69d19a2e315483bc41e059b40d6d9fdccf2599@ec2-107-22-229-213.compute-1.amazonaws.com:5432/d2r8p5ai580nqq"
export APP_CONFIG="production"
export SECRET_KEY="mYd3rTyL!tTl#sEcR3t"
export FLASK_APP=run.py

# Run the app
# echo ======= Launching the application server =======
# python manage.py runserver --host 0.0.0.0 --port 5000

# Install nginx
echo ======= Installing nginx =======
sudo apt-get install -y nginx

# Configure nginx routing
echo ======= Configuring nginx =======
echo ======= Removing default config =======
sudo rm -rf /etc/nginx/sites-available/default
sudo rm -rf /etc/nginx/sites-enabled/default
echo ======= Replace config file =======
sudo bash -c 'cat <<EOF> /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8000/;
        proxy_set_header HOST \$host;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF'

echo ======= Copy the file to enabled sites =======
cp /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Ensure nginx server is running
echo ====== Checking nginx server status ========
sudo systemctl status nginx

# Serve the web app through gunicorn
gunicorn app:APP

