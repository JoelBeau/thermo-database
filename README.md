
# Thermodynamics Database Project

This project automates the setup of a thermodynamics database, which stores thermodynamic property tables, using MySQL and bash. Additionally, it includes a user-friendly Python script for querying the data, making it easy to retrieve thermodynamic properties with minimal effort.

## Install Docker
   ```bash
      sudo apt-get install docker
   ```

### How to Run

1. Clone the repository:

   ```bash
      git clone https://github.com/JoelBeau/thermo-database.git
      cd thermo-database
   ```

2. Run the setup script to install dependencies and set up the database:

   ```bash
   sudo ./setup.sh
   ```


4. Run the Python lookup script to query the database:

   ```bash
   ./table2cmd.py
   ```

