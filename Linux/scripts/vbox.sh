#!/bin/bash

sudo apt update && sudo apt -y full-upgrade
sudo apt install -y gcc make linux-headers-$(uname -r) libqt5core5a libqt5gui5 libqt5widgets5 libqt5opengl5 libqt5printsupport5 libqt5x11extras5 libqt5network5 libqt5dbus5
sudo apt -y autoremove && sudo apt -y autoclean

read -p "Have you already rebooted the system after the last full-upgrade? (y/n): " response
if [ "$response" = "y" ]; then
  echo "Continuing with the installation..."
else
  echo "Rebooting!!!"
  sudo reboot
  echo "Please run the script again after the system comes back online."
  exit
fi

sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
sudo nano /etc/apt/sources.list.d/virtualbox.list
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib"
sudo apt update && sudo apt install virtualbox-7.1

# Change number based on virtualbox version installed
wget https://download.virtualbox.org/virtualbox/7.1.0/Oracle_VirtualBox_Extension_Pack-7.1.0.vbox-extpack
sudo VBoxManage extpack install Oracle_VirtualBox_Extension_Pack-7.1.0.vbox-extpack
sudo VBoxManage list extpacks
