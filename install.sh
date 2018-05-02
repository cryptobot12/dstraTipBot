#!/bin/bash -e

sudo apt-get update
sudo apt-get install python3 python3-pip

sudo pip3 install python-telegram-bot --upgrade
sudo pip3 install discord.py --upgrade

sudo mkdir -p /opt/dstraTipBot

sudo cp -prf ~/dstraTipBot/dstraDiscordTipBot /etc/init.d/dstraDiscordTipBot
sudo cp -prf ~/dstraTipBot/dstraDiscordTipBot.py /opt/dstraTipBot/dstraDiscordTipBot.py
sudo cp -prf ~/dstraTipBot/dstraTelegramTipBot /etc/init.d/dstraTelegramTipBot
sudo cp -prf ~/dstraTipBot/dstraTelegramTipBot.py /opt/dstraTipBot/dstraTelegramTipBot.py
sudo cp -prf ~/dstraTipBot/pickledb.py /opt/dstraTipBot/pickledb.py

rm -rf ~/dstraTipBot

echo "DONE!!"
