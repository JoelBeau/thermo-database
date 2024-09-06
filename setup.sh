# #Install dependencies
# sudo ../scripts/install_depend.sh

# #Create the database
# sudo ../scripts/create_thermo_database.sh

#Add the bin directory to the PATH
echo "export PATH=\$PATH:$(pwd)/bin" >> ~/.bashrc

# # Apply the changes to the current session
source ~/.bashrc