#!/bin/bash

#chmod 777 validate_sourcelist.sh
#sudo ./validate_sourcelist.sh

sudo apt-get update
sudo apt-get full-upgrade
sudo apt-get dist-upgrade
sudo apt-get upgrade
sudo apt-get install -y kali-linux-large
sudo apt-get install -y kali-tools-windows-resources
sudo apt-get install -y kali-tools-crypto-stego
sudo apt-get install -y kali-tools-fuzzing

sudo apt-get remove --purge code-oss
sudo apt-get remove --purge apktool
sudo apt-get remove --purge burpsuite

sudo apt-get install -y gnome-terminal
sudo apt-get install -y terminator
sudo apt-get install -y htop
sudo apt-get install -y neofetch
sudo apt-get install -y ranger
sudo apt-get install -y proxychains
sudo apt-get install -y tor
sudo apt-get install -y bloodhound
sudo apt-get install -y neo4j
sudo apt-get install -y xclip
sudo apt-get install -y scrub
sudo apt-get install -y feroxbuster
sudo apt-get install -y alacarte
sudo apt-get install -y cupp 
sudo apt-get install -y pipx

sudo chown -R cyb3r3xpl0it:cyb3r3xpl0it /opt