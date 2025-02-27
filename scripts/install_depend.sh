#!/bin/bash

echo "Installing dependencies..."

# Update and upgrade the system
# sudo apt-get update -y
# sudo apt-get full-upgrade -y

#Install Dependencies applications and libraries
# sudo apt-get install mysql-server -y
sudo apt-get install python3 -y
sudo apt-get install python-is-python3 -y
sudo apt-get install libmysqlclient-dev -y
sudo apt-get install pkg-config -y

sudo service mysql start

#Install Python libraries
sudo apt-get install python3-pandas -y
sudo apt-get install python3-tabulate -y
sudo apt-get install python3-pip -y

pip install mysqlclient==2.1.1
pip install mysql-connector-python

#Create the database
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS thermo;
EOF

echo "Creating MySQL user thermo_user..."

sudo mysql <<EOF
CREATE USER 'thermo_user'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON thermo.* TO 'thermo_user'@'localhost';
EOF

echo "thermo_user created and given access to thermo database"

echo "Dependencies installed successfully"

