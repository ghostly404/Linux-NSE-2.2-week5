#!/bin/bash

sudo apt-get update

sudo apt-get install -y rsyslog

echo '$*.* @10.1.0.7:514' | sudo tee -a /etc/rsyslog.conf

sudo systemctl restart rsyslog

sudo systemctl enable rsyslog
