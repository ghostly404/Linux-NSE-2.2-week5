udo apt install ansible -y

#access de ansible conf en vul correcte informatie aan

#---------------------------------------------------------------
echo '[server]'         >>  ~/ansible/hosts
echo 'server1 ansible_host=10.1.0.7' >> ~/ansible/hosts
echo '[all:vars]' >> ~/ansible/hosts
echo 'ansible_python_interpreter=/usr/bin/python3' >> ~/ansible/hosts
#-----------------------------------------------------------------

sudo ansible all -m ping -u wordpress

sudo apt install git -y
git --version
sudo git clone https://github.com/wildfoxcz/Ansible-WordPress-installation.git
sudo chmod 775 Ansible-WordPress-installation
sudo sed -e 's/192.168.111.54/10.1.0.7/' -i /home/azureuser/Ansible-WordPress-installation/playbook.yml
sudo sed -e 's/tribetraining/client/' -i /home/azureuser/Ansible-WordPress-installation/playbook.yml
sudo sed -e 's/root/client/' -i /home/azureuser/Ansible-WordPress-installation/playbook.yml
sudo sed -e 's/root/client/' -i /home/azureuser/Ansible-WordPress-installation/roles/mysql/tests/test.yml
sudo sed -e 's/root/client/' -i /home/azureuser/Ansible-WordPress-installation/roles/php/tests/test.yml
sudo sed -e 's/root/client/' -i /home/azureuser/Ansible-WordPress-installation/roles/server/tests/test.yml 
sudo sed -e 's/root/client/' -i /home/azureuser/Ansible-WordPress-installation/roles/wordpress/tests/test.yml 
sudo sed -e 's/192.168.11.136/192.168.11.137/' -i /home/azureuser/Ansible-WordPress-installation/hosts
sudo sed -e 's/worpdress/client/' -i /home/azureuser/Ansible-WordPress-installation/hosts
echo 'server1 ansible_host=10.1.0.7' >> /home/azureuser/Ansible-WordPress-installation/hosts
