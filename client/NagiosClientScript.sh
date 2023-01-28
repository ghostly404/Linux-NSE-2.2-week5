#!/bin/bash

#hostname 460202Week5Client
#IP Clienthost 10.1.0.8

sudo apt-get install nagios-nrpe-server nagios-plugins -y

sudo echo "server_address=10.1.0.46"         >>  /etc/nagios/nrpe.cfg

sed -e 's/allowed_hosts=127.0.0.1,::1/allowed_hosts=127.0.0.1, 10.1.0.7/' -i /etc/nagios/nrpe.cfg

sudo systemctl restart nagios-nrpe-server
sudo systemctl enable nagios-nrpe-server

sudo ufw enable

sudo ufw allow 5666/tcp

sudo ufw allow ssh