#!/bin/bash

echo "Installing dependencies..."

# Update and upgrade the system
sudo apt-get update -y
sudo apt-get full-upgrade -y

#Install Dependencies applications and libraries
sudo apt-get install mysql-server -y
sudo apt-get install python3 -y
sudo apt-get install python-is-python3 -y
sudo apt-get install pip3 -y
sudo apt-get install libmysqlclient-dev -y
sudo apt-get install pkg-config -y

USER="$(whoami)"

sudo service mysql start

#Create the database
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS thermo;
EOF

PASSWORD=""

read -p "Enter the SQL username: " USER

read -sp "Enter the SQL password: " PASSWORD

echo "Creating user mysql user $USER..."

sudo mysql <<EOF
CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWORD';
GRANT ALL PRIVILEGES ON thermo.* TO '$USER'@'localhost';
EOF

echo "User $USER created and given access to thermo database"

echo "Dependencies installed successfully"

