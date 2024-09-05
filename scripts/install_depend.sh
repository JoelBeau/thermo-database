#!/bin/bash

echo "Installing dependencies..."

# Update and upgrade the system
sudo apt-get update
sudo apt-get full-upgrade -y

#Install Dependencies applications and libraries
sudo apt-get install mysql-server
sudo apt-get install python
sudo apt-get install python-is-python3
sudo apt-get install pip
sudo apt-get install libmysqlclient-dev

#Install Python libraries
pip install pandas
pip install mysql
pip install tabulate

#Create the database
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS thermo;
EOF

USER="$(whoami)"

read -p "Enter the SQL username: " USER

read -sp "Enter the SQL password: " PASSWORD

echo "Creating user mysql user $USER..."

sudo mysql <<EOF
CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWORD'
GRANT ALL PRIVILEGES ON thermo.* TO '$USER'@'localhost'
EOF

echo "User $USER created and given access to thermo database"

echo "Finished installing dependencies"

