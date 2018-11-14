#Download base image ubuntu 16.04
FROM ubuntu:16.04

# Update Software repository
RUN apt-get update -y && \
apt-get install -y wget

# Add salt repo key
RUN wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -

# Add repo to apt
RUN echo deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main >> /etc/apt/sources.list.d/saltstack.list

# Update Software repository
RUN apt-get update -y

# Install salt
RUN apt-get install -y salt-master salt-minion salt-ssh salt-cloud salt-doc vim tmux htop git && \
    rm -rf /var/lib/apt/lists/*

# Create salt directories
RUN mkdir -p /srv/salt && \
mkdir -p /srv/pillar

# Copy the master file
COPY master.conf /etc/salt/master

# 
CMD echo 127.0.0.1 localhost salt >> /etc/hosts && \
/etc/init.d/salt-master start && \
/etc/init.d/salt-minion start && \
bash