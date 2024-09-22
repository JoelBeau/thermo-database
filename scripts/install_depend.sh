#!/bin/bash

echo "Installing dependencies..."

# Update and upgrade the system
# sudo apt-get update -y
# sudo apt-get full-upgrade -y

#Install Dependencies applications and libraries
sudo apt-get install mysql-server -y
sudo apt-get install python3 -y
sudo apt-get install python-is-python3 -y
sudo apt-get install pip3 -y
sudo apt-get install libmysqlclient-dev -y
sudo apt-get install pkg-config -y

sudo service mysql start

#Install Python libraries
pip3 install mysql
pip3 install pandas
pip3 install tabulate

#Create the database
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS thermo;
EOF

echo "Creating MySQL user thermo_user..."

sudo mysql <<EOF
CREATE USER 'thermo_user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON thermo.* TO 'thermo_user'@'localhost';
EOF

echo "thermo_user created and given access to thermo database"

echo "Dependencies installed successfully"

