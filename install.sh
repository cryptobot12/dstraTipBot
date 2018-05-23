#!/bin/bash -e

sudo apt-get update
sudo apt-get install python3 python3-pip

sudo pip3 install discord.py --upgrade

sudo mkdir -p /opt/dstraTipBot

sudo cp -prf ~/dstraTipBot/dstraDiscordTipBot /etc/init.d/dstraDiscordTipBot
sudo cp -prf ~/dstraTipBot/dstraDiscordTipBot.py /opt/dstraTipBot/dstraDiscordTipBot.py
sudo cp -prf ~/dstraTipBot/pickledb.py /opt/dstraTipBot/pickledb.py

rm -rf ~/dstraTipBot

echo "DONE!!"
