
# Thermodynamics Database Project
This project automates the creation and installation of a thermodynamics database, which stores common thermodynamic property tables, using MySQL and bash. Additionally, it includes a user-friendly Python script for querying the data, making it easy to retrieve thermodynamic properties with minimal effort.

## Notice
-This project is meant to run as a containerized application using Docker, on a Linux distribution. Right now, it is not meant to be run on Windows or MacOS. If you have suggestions for making it work on those systems, please let me know.  
-If you are on a different Linux distribution other than Ubuntu, you may need to change the installation commands to match your distribution.  
-This project is a work in progress, and I am open to suggestions for improvement. Please let me know if you have any ideas or feedback.

## Dependencies
- Docker
- MySQL
- Python 3
- Python libraries: mysql-connector-python, pandas, mysqlclient


## Install Docker if not already installed
   ```bash
      sudo apt-get install docker
   ```

### How to use

1. Clone the repository:

   ```bash
      git clone https://github.com/JoelBeau/thermo-database.git
      cd thermo-database
   ```

2. Create a docker image

   ```bash
      docker build --progess=tty -t thermo-database .
   ```
   Note: ```bash --progess=tty``` is optional, just shows each command running. You can also rename the image to anything you want.

3. Run docker container interactively

   ```bash
      docker run -it --name thermo-database thermo-database
   ```
   Note: you may change the name to anything you want, or not use it at all (docker will assign random name), 
   but it is useful for stopping and starting the container.

4. Start MySQL server
   
   This will fail the first time, but it fixes itself.  After it fails, just run it again.

   ```bash
      sudo service mysql start
   ```
   If anyone has a better way to do this, please let me know.

5. Run the python script for querying the database

   ```bash
      table2cmd
   ```
   If you have suggestions for improving the script, please let me know.

6. Stop the docker container

   ```bash
      exit
   ```

7. To start the container and use it again

   ```bash
      docker start thermo-database
      docker attach thermo-database
   ```


