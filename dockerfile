FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update system
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get full-upgrade -y 

# Install sudo and add test user to the sudo group
RUN apt-get install -y sudo tzdata

RUN echo "America/Chicago" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata

# Make user and give sudo privileges
RUN useradd -ms /bin/bash dbuser \
    && echo "dbuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/test

USER dbuser

WORKDIR /home/dbuser

# Install git and clone repo
RUN sudo apt-get install git -y \
    && git clone https://github.com/JoelBeau/thermo-database.git

WORKDIR /home/dbuser/thermo-database

# Run setup script from repo and update path
RUN sudo ./setup.sh \
    && echo 'export PATH=$PATH:/home/dbuser/thermo-database' >> /home/dbuser/.bashrc

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENV DEBIAN_FRONTEND=interactive

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["bash"]

