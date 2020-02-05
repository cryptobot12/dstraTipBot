#!/usr/bin/env bash

#:: EPG-Coin team
#:: Copyright // 2019-10-05
cat << "EPG"

EPG

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo $(date)
echo ""
echo "Good day. This is automated cold masternode setup for ENCOCOINPLUS project. Auto installer was tested on specific environment. Don't try to install masternode with undocumented operating system!"
echo ""
echo "Installation content:"
echo "ENCOCOINPLUS core"
echo
echo "Setup can be launched"
echo "Do you agree?"
echo -e "${GREEN}(y)es${NC}/${RED}(n)o"${NC}?
read agree
            if [ "$agree" != "y" ]; then
               echo "Setup canceled" && exit 1
            fi
OS_version=$(cat /etc/lsb-release | grep -c bionic)
OS_version2=$(cat /etc/lsb-release | grep -c xenial)
            if [ "$OS_version" -ne "1" ]; then
                    echo ""
			echo -e "${RED}Looks like your OS version is not Ubuntu 18.04 Bionic //${GREEN} Maybe Ubuntu 16.04 Xenial? - Checking...${NC}"

                        if [ "$OS_version2" -eq "1" ]; then
                                echo ""
                        else
                                echo ""
                                echo -e "${RED}Looks like your OS version is not Ubuntu 16.04 Xenial or Ubuntu 18.04 Bionic${NC}" && exit 1
                        fi
            fi
sudo apt-get update -y
if [ $? -ne "0" ]; then echo -e "${RED}Cannot update ubuntu repos${NC}" && exit 1; fi
sudo apt-get install software-properties-common -y 1> /dev/null
if [ $? -ne "0" ]; then echo -e "${RED}Unable to install software-properties-common${NC}" && exit 1; fi
sudo add-apt-repository universe -y 1> /dev/null
if [ $? -ne "0" ]; then echo -e "${RED}Unable to add repository universe${NC}" && exit 1; fi
sudo apt-get install dnsutils jq curl -y 1> /dev/null
if [ $? -ne "0" ]; then echo -e "${RED}Unable to install dnsutils jq curl${NC}" && exit 1; fi
echo ""
wanip=$(curl -s 4.ipquail.com/ip)
if [ -z "${wanip}" ]; then
    echo -e "${RED}Sorry, we don't know your external IPv4 addr${NC}" && echo ""
    echo -e "${GREEN}Input your IPv4 addr manually:${NC}" && read wanip
fi
echo "Your external IP is $wanip"
echo -e "${GREEN}(y)es${NC}/${RED}(n)o"${NC}
read wan
            if [ "$wan" != "y" ]; then
               echo -e "${RED}Sorry, we don't know your external IPv4 addr${NC}" && exit 1
            fi
# Check install or update for Bionic //
[ -f /etc/apt/sources.list.d/bitcoin-ubuntu-bitcoin-bionic.list ]
            if [ "$?" -eq "0" ]; then
                    echo ""
                    echo -e "Looks like you are trying to setup second time? You need fresh ${GREEN}(i)nstall${NC} or ${RED}(u)pdate${NC} your MN?"
					echo -e "${GREEN}i${NC}/${RED}u"${NC}?
					read setorupd
					if [ "$setorupd" = "u" ]; then
					sudo systemctl stop epgccore &&
					echo -e "${GREEN}1/5 ENCOCOINPLUS service is stopped${NC}" &&
					cd /usr/bin &&
					sudo rm -fr epgc-cli epgcd &&
					cd ~ &&
					echo -e "${GREEN}2/5 Old ENCOCOINPLUS wallet is deleted${NC}" &&
					wget https://github.com/Encocoin/encocoinplus/releases/download/1.0.2/epg-1.0.2-ubuntu1804-daemon.zip &&
					echo -e "${GREEN}3/5 ENCOCOINPLUS wallet is downloaded${NC}" &&
					unzip -o epg-1.0.2-ubuntu1804-daemon.zip &&
					sudo cp -fr.epgc/epgc-cli.epgc/epgcd /usr/bin/ &&
					cd /usr/bin &&
					chmod -R 755 epgc-cli epgcd &&
					cd ~ &&
					echo -e "${GREEN}4/5 ENCOCOINPLUS wallet is updated${NC}" &&
					sudo systemctl start epgccore &&
					echo -e "${GREEN}5/5 ENCOCOINPLUS service is started${NC}" &&
					echo -e "${GREEN}Update is full completed.${NC}" && exit 1; fi
					if [ "$setorupd" = "i" ]; then
					sudo systemctl stop epgccore &&
					echo "" &&
					echo -e "${GREEN}Setup ENCOCOINPLUS masternode started${NC}" &&
					sleep 5
					else
					echo "" &&
					echo -e "${RED}Sorry, we cannot continue${NC}" && exit 1;   fi
			fi
			
			
# Check install or update for Xenial //
[ -f /etc/apt/sources.list.d/bitcoin-ubuntu-bitcoin-xenial.list ]
            if [ "$?" -eq "0" ]; then
                    echo ""
                    echo -e "Looks like you are trying to setup second time? You need fresh ${GREEN}(i)nstall${NC} or ${RED}(u)pdate${NC} your MN?"
					echo -e "${GREEN}i${NC}/${RED}u"${NC}?
					read setorupd
					if [ "$setorupd" = "u" ]; then
					sudo systemctl stop epgccore &&
					echo -e "${GREEN}1/5 ENCOCOINPLUS service is stopped${NC}" &&
					cd /usr/bin &&
					sudo rm -fr epgc-cli epgcd &&
					cd ~ &&
					echo -e "${GREEN}2/5 Old ENCOCOINPLUS wallet is deleted${NC}" &&
					wget https://github.com/zer-dex-coin/zerdex-core/releases/download/1.3.0.0.epgc.ubuntu16.04.zip &&
					echo -e "${GREEN}3/5 ENCOCOINPLUS wallet is downloaded${NC}" &&
					unzip -o.epgc*.zip &&
					sudo cp -fr.epgc/epgc-cli.epgc/epgcd /usr/bin/ &&
					cd /usr/bin &&
					chmod -R 755 epgc-cli epgcd &&
					cd ~ &&
					echo -e "${GREEN}4/5 ENCOCOINPLUS wallet is updated${NC}" &&
					sudo systemctl start epgccore &&
					echo -e "${GREEN}5/5 ENCOCOINPLUS service is started${NC}" &&
					echo -e "${GREEN}Update is full completed.${NC}" && exit 1; fi
					if [ "$setorupd" = "i" ]; then
					sudo systemctl stop epgccore &&
					echo "" &&
					echo -e "${GREEN}Setup ENCOCOINPLUS masternode started${NC}" &&
					sleep 5
					else
					echo "" &&
					echo -e "${RED}Sorry, we cannot continue${NC}" && exit 1;   fi
            
			fi
if [ "$OS_version" -eq "1" ]; then
# Install dep. for Bionic //
        sudo add-apt-repository ppa:bitcoin/bitcoin -y
	if [ $? -ne "0" ]; then echo "Unable to add bitcoin dependencies" && exit 1; fi
        sudo apt-get update -y
	if [ $? -ne "0" ]; then echo "Cannot update ubuntu repos" && exit 1; fi
        sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
	if [ $? -ne "0" ]; then echo "Unable to install libdb dependencies" && exit 1; fi
        sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common libminiupnpc-dev libcrypto++-dev libboost-all-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev libboost-thread-dev libssl-dev libssl-dev software-properties-common unzip libzmq3-dev ufw wget git python-openssl -y
		if [ $? -ne "0" ]; then echo "Unable to install major dependencies" && exit 1; fi
		sudo wget https://github.com/zer-dex-coin/MN-Script/blob/master/libs.zip
		unzip -o libs.zip
		sudo cp -fr libboost_filesystem.so.1.58.0 libboost_chrono.so.1.58.0 libboost_program_options.so.1.58.0 libboost_system.so.1.58.0 libboost_thread.so.1.58.0 libminiupnpc.so.10 libevent_core-2.0.so.5 libevent_pthreads-2.0.so.5 libevent-2.0.so.5 /usr/lib/
		sudo rm -fr libboost_filesystem.so.1.58.0 libboost_chrono.so.1.58.0 libboost_program_options.so.1.58.0 libboost_system.so.1.58.0 libboost_thread.so.1.58.0 libminiupnpc.so.10 libevent_core-2.0.so.5 libevent_pthreads-2.0.so.5 libevent-2.0.so.5 libs.zip
        if [ $? -ne "0" ]; then echo "Unable to install libboost dependencies" && exit 1; fi
        else
# Install dep. for Xenial //		
        sudo add-apt-repository ppa:bitcoin/bitcoin -y
        if [ $? -ne "0" ]; then echo "Unable to add bitcoin dependencies" && exit 1; fi
        sudo apt-get update -y
        if [ $? -ne "0" ]; then echo "Cannot update ubuntu repos" && exit 1; fi
        sudo apt-get install libdb4.8-dev libdb4.8++-dev -y
        if [ $? -ne "0" ]; then echo "Unable to install libdb dependencies" && exit 1; fi
        sudo apt-get install libboost-system1.58-dev libboost-system1.58.0 -y
        if [ $? -ne "0" ]; then echo "Unable to install libboost dependencies" && exit 1; fi
        sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-pthreads-2.0-5 libevent-dev bsdmainutils software-properties-common libminiupnpc-dev libcrypto++-dev libboost-all-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev libboost-thread-dev libssl-dev libssl-dev software-properties-common unzip libzmq3-dev ufw wget git python-openssl -y
        if [ $? -ne "0" ]; then echo "Unable to install major dependencies" && exit 1; fi
        fi
# Download EPG sources //
echo ""
echo -e "${GREEN}1/6 Downloading ENCOCOINPLUS sources...${NC}" 
echo ""
cd /usr/bin
sudo rm -fr epgc-cli epgcd
cd ~/.epgc
sudo rm -R -fr database .lock peers.dat blocks db.log masternode.conf epgc.conf zerocoin budget.dat debug.log mncache.dat epgcd.pid chainstate fee_estimates.dat mnpayments.dat sporks
cd ~

            if [ "$OS_version" -eq "1" ]; then
                wget https://github.com/Encocoin/encocoinplus/releases/download/1.0.2/epg-1.0.2-ubuntu1804-daemon.zip
		if [ $? -ne "0" ]; then echo "Failed to download epgcd binary" && exit 1; fi
            elif [ "$OS_version2" -eq "1" ]; then
                wget https://github.com/zer-dex-coin/zerdex-core/releases/download/1.3.0.0.epgc.ubuntu16.04.zip
		if [ $? -ne "0" ]; then echo "Failed to download epgcd binary" && exit 1; fi
            fi
# Manage coin daemon and configuration //
unzip -o.epgc*.zip
echo ""
sudo cp -fr.epgc/epgc-cli.epgc/epgcd /usr/bin/
cd /usr/bin
chmod -R 755 epgc-cli epgcd
cd ~
mkdir -p ~/.epgc/
touch ~/.epgc/epgc.conf
cat << EOF > ~/.epgc/epgc.conf
rpcuser=epgcuser
rpcpassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
txindex=1
rpcport=29443
listen=1
port=29442
rpcallowip=127.0.0.1
daemon=1
masternode=1


EOF

#Create epg.service
echo -e "${GREEN}2/6 Create epgc.service for systemd${NC}"
echo ""
echo \
"[Unit]
Description=ENCOCOINPLUS Core daemon & service
After=network.target

[Service]
User=root
Type=forking
ExecStart=/usr/bin/epgcd -daemon -pid=$(echo $HOME)/.epgc/epgcd.pid --datadir=$(echo $HOME)/.epgc/
PIDFile=$(echo $HOME)/.epgc/epgcd.pid
ExecStop=/usr/bin/epgc-cli stop
Restart=always
RestartSec=3600
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5

[Install]
WantedBy=default.target" | sudo tee /etc/systemd/system/epgccore.service

sudo chmod 664 /etc/systemd/system/epgccore.service

sudo systemctl enable epgccore

real_user=$(echo $USER) 

sudo chown -R $real_user:$real_user $(echo $HOME)/.epgc/

# Check if user is root? If not create sudoers files to manage systemd services
echo ""
echo -e "${GREEN}3/6 Check if user is root? If not create sudoers files to manage systemd services${NC}"
if [ "$EUID" -ne 0 ]; then
sudo echo \
"%$real_user ALL= NOPASSWD: /bin/systemctl start epgccore
%$real_user ALL= NOPASSWD: /bin/systemctl stop epgccore
%$real_user ALL= NOPASSWD: /bin/systemctl restart epgccore" | sudo tee /tmp/$real_user
sudo mv /tmp/$(echo $real_user) /etc/sudoers.d/
fi

# Start epgc daemon, wait for wallet creation //
sudo systemctl start epgccore &&
echo "" ; echo "Please wait for few minutes..."
sleep 12 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
echo ""
sudo systemctl stop epgccore &&
echo ""
echo -e "Shutting down daemon, reconfiguring epgc.conf, we want to know your cold wallet ${GREEN}masternodeprivkey${NC} (example: 7UwDGWAKNCAvyy9MFEnrf4JBBL2aVaDm2QzXqCQzAugULf7PUFD), please input now:"
echo""
read masternodeprivkey
privkey=$(echo $masternodeprivkey)
checkpriv_key=$(echo $masternodeprivkey | wc -c)
if [ "$checkpriv_key" -ne "52" ];
then
	echo ""
	echo "Looks like your $privkey is not correct, it should cointain 52 symbols, please paste it one more time"
	read masternodeprivkey
privkey=$(echo $masternodeprivkey)
checkpriv_key=$(echo $masternodeprivkey | wc -c)

if [ "$checkpriv_key" -ne "52" ];
then
        echo "Something wrong with masternodeprivkey, cannot continue" && exit 1
fi
fi
echo ""
echo "Give some time to shutdown the wallet..."
echo ""
sleep 15 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
cat << EOF > ~/.epgc/epgc.conf
rpcuser=epgcuser
rpcpassword=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo '')
txindex=1
rpcport=29443
listen=1
port=29442
rpcallowip=127.0.0.1
daemon=1
masternode=1
masternodeaddr=$wanip
masternodeprivkey=$privkey


EOF

# Firewall //
echo -e "${GREEN}4/6 Update firewall rules${NC}"
echo ""
echo "Update firewall rules"
sudo /usr/sbin/ufw limit ssh/tcp comment 'Rate limit for openssh server' 
sudo /usr/sbin/ufw allow 29442/tcp comment 'ENCOCOINPLUS Wallet daemon'
sudo /usr/sbin/ufw --force enable
echo ""

# Fast download Blockchain
cd ~
cd .epgc
sudo rm -R blocks chainstate
echo ""
echo -e "${GREEN}5/6 please wait, installation script downloads ENCOCOINPLUS blockchain ${NC}"
echo ""
wget https://bitbucket.org/encocoindev/encocoinplus/downloads/bootstrap_epg_V1.0.2.zip
unzip -o bootstrap_epg_V1.0.2.zip
sudo rm -f  bootstrap_epg_V1.0.2.zip

# Final start
echo ""
echo -e "${GREEN}6/6 Masternode config done, ENCOCOINPLUS wallet installed - starting again${NC}"
echo ""
sudo systemctl start epgccore
echo -e "${RED}The blockchain is syncing from scratch. You have to wait few hours to sync all the blocks!${NC}"
echo ""
echo "Setup summary:"
echo "Masternode privkey: $privkey"
echo "Your external IPv4 addr: $wanip"
echo "Installation log: ~/epgc_masternode_installation.log"
echo "ENCOCOINPLUS Core datadir: "$(echo $HOME/.epgc/)""
echo ""
echo -e "Need additional help? Please visit ENCOCOINPLUS Discord channel${NC}"
echo ""
