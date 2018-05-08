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
pip3 install -y virtualenv

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
echo ======= Launching the application server =======
flask run --host 0.0.0.0 port 5000
