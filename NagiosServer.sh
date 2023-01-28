#!/bin/bash

alias goback="cd /home/azureuser/"

sudo apt update && sudo apt upgrade -y

sudo apt install -y autoconf bc gawk dc build-essential gcc libc6 make wget unzip apache2 php libapache2-mod-php libgd-dev libmcrypt-dev make libssl-dev snmp libnet-snmp-perl gettext

mkdir nagios

cd nagios/

sudo wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz

sudo tar -xvf nagios-4.4.6.tar.gz

goback
cd nagios/nagios-4.4.6/

sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled

sudo make all

sudo make install-groups-users
sudo usermod -a -G nagios www-data

sudo make install
sudo make install-init
sudo make install-commandmode
sudo make install-config
sudo make install-webconf
sudo a2enmod rewrite cgi


echo "Vul een wachtwoord voor admin account"
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

goback
cd nagios/
sudo apt install monitoring-plugins nagios-nrpe-plugin -y

goback

sudo echo "cfg_dir=/usr/local/nagios/etc/servers"         >>  /usr/local/nagios/etc/nagios.cfg

sudo echo "cfg_dir=/usr/local/nagios/etc/printers"         >>  /usr/local/nagios/etc/nagios.cfg

sudo echo "cfg_dir=/usr/local/nagios/etc/switches"         >>  /usr/local/nagios/etc/nagios.cfg

sudo echo "cfg_dir=/usr/local/nagios/etc/routers"         >>  /usr/local/nagios/etc/nagios.cfg



cd /usr/local/nagios/etc

sudo mkdir servers printers switches routers

goback

sudo sed -i '25d' /usr/local/nagios/etc/resource.cfg
sudo echo '$USER1$=/usr/lib/nagios/plugins'         >>  /usr/local/nagios/etc/resource.cfg

sudo echo 'define command{
        command_name check_nrpe
	        command_line $USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
	}'         >>  /usr/local/nagios/etc/objects/commands.cfg


goback
cd /usr/local/nagios/etc/
sudo chmod 775 servers/
sudo chown nagios:nagios servers/

goback

cd /usr/local/nagios/etc/servers/

sudo touch ubuntu.cfg

goback

sudo tee /usr/local/nagios/etc/servers/ubuntu.cfg << EOF
#Replace :
# host_name = ubuntu
# alias = Your-Alias
# address = 10.1.0.8
define host{
use                     linux-server
host_name               Week5ChrisJanseClient
alias                   SlaveDNS
address                 10.1.0.8
}

define service{
use                             local-service
host_name                       Week5ChrisJanseClient
service_description             Root / Partition
check_command                   check_nrpe!check_disk
}
define service{
use                             local-service
host_name                       Week5ChrisJanseClient
service_description             /mnt Partition
check_command                   check_nrpe!check_mnt_disk
}

define service{
use                             local-service
host_name                       Week5ChrisJanseClient
service_description             Current Users
check_command                   check_nrpe!check_users
}

define service{
use                             local-service
host_name                       Week5ChrisJanseClient
service_description             Total Processes
check_command                   check_nrpe!check_total_procs
}

define service{
use                             local-service
host_name                       Week5ChrisJanseClient
service_description             Current Load
check_command                   check_nrpe!check_load
}

EOF

cd /usr/local/nagios/etc/servers/

sudo chown nagios:nagios ubuntu.cfg
sudo chmod 664 ubuntu.cfg

sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

sudo ufw enable

sudo ufw allow 5666/tcp

sudo ufw allow apache

sudo systemctl restart apache2
sudo systemctl restart nagios

sudo systemctl enable apache2
sudo systemctl enable nagios

