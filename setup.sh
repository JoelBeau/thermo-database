#!/bin/bash

# #Install dependencies
sudo scripts/install_depend.sh

# #Create the database
sudo scripts/create_thermo_database.sh

chmod +x table2cmd.py