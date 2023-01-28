#!/bin/bash

sudo apt-get update

sudo apt-get install -y rsyslog

echo '$ModLoad imudp' | sudo tee -a /etc/rsyslog.conf
echo '$UDPServerRun 514' | sudo tee -a/etc/rsyslog.conf
echo '$template remote-incoming-logs, "/var/log/%HOSTNAME%/%PROGRAMNAME%.log"'| sudo tee -a /etc/rsyslog.conf
echo '*.* ?remote-incoming-logs' | sudo tee -a /etc/rsyslog.conf
echo '& ~' | sudo tee -a /etc/ryslog.conf

sudo systemctl restart rsyslog

sudo systemctl enable rsyslog
