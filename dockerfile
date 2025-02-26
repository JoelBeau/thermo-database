FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update system
RUN apt-get update && apt-get upgrade -y && apt-get full-upgrade -y

# Install sudo and add test user to the sudo group
RUN apt-get install -y sudo tzdata

RUN echo "America/Chicago" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

# Make user
RUN useradd -ms /bin/bash test

# Give test user sudo privileges
RUN echo "test ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/test

USER test

WORKDIR /home/test

RUN sudo apt-get install git -y && git clone https://github.com/JoelBeau/thermo-database.git

WORKDIR /home/test/thermo-database

RUN sudo ./setup.sh

ENV DEBIAN_FRONTEND=interactive
