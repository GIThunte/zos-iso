#!/bin/bash
echo " === This is an image configuration script inside the chroot environment ==="
echo "ZOS" > /etc/hostname
#passwd root
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt update -y
apt install -y sudo iputils-ping net-tools openssh-server wget vim nano debconf devscripts gnupg htop
sudo apt-get install xdm -y
sudo apt-get install xfce4 -y
sudo apt-get install htop -y
sudo apt-get install nmap -y
sudo apt-get install python3.5 -y
sudo apt-get install nginx -y 
sudo apt-get install libreoffice-core -y

################### Telegram #######################
sudo add-apt-repository ppa:atareao/telegram -y
sudo apt update -y
sudo apt install telegram -y

################# sublime text #####################
sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
sudo apt-get update -y
sudo apt-get install sublime-text-installer -y

##################### gimp #########################
sudo apt-get install gimp -y

#################### firefox #######################
sudo apt-get install firefox -y 

################### google chrome ##################

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-get update -y
sudo apt-get install google-chrome-stable -y