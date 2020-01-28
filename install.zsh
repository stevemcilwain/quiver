#!/bin/bash
export DEBIAN_FRONTEND=noninteractive;
echo "[*] Starting Install... [*]"

echo "[*] Upgrade installed packages to latest [*]"
echo -e "\nRunning a package upgrade...\n"
apt-get -qq update && apt-get -qq dist-upgrade -y
apt full-upgrade -y
apt-get autoclean

echo "[*] Install dependencies [*]"
echo -e "\nInstalling default packages...\n"
apt-get -y install git unzip 
apt-get -y install nmap nikto wget curl

echo "[*] Install Chrome.[*]"
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P ~/
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb
apt-get -f install -y
dpkg -i --force-depends ~/google-chrome-stable_current_amd64.deb

echo "[*] Making Bounty Scan Area.. [*]"
mkdir -p /home/tools/mass-bounty/
mkdir -p /home/tools/mass-bounty/angular-results/
mkdir -p /home/tools/mass-bounty/crlf-results/
mkdir -p /home/tools/mass-bounty/dirsearch-results/
mkdir -p /home/tools/mass-bounty/jexboss-results/
mkdir -p /home/tools/mass-bounty/tko-results/
mkdir -p /home/tools/mass-bounty/s3-results/



__URL_ALL_TXT="https://gist.github.com/stevemcilwain/2e9d56ae806d7fc050a0bf6c1e02038f/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt"
__URL_SONAR_FDNS="https://opendata.rapid7.com/sonar.fdns_v2/2019-12-27-1577404985-fdns_a.json.gz"
__URL_SONAR_RDNS=""

# Data

    sudo wget -nd -P /opt/data/all __URL_ALL_TXT
    sudo wget -nd -P /opt/data/fdns __URL_SONAR_FDNS




# Manual Install

- BurpSuite / OWASP Zap
- Chromium / Chrome / Firefox

# quiver dependencies




sudo apt-get install -y xclip whatweb curl jq pigz

#### data

# All.txt



# Rapid 7 Sonar - Forward DNS
wget 





cat 2019-12-27-1577404985-fdns_a.json.gz | pigz -dc | grep ".yelp.com" | jq`







gobuster -w --seclists/Discovery/Web_Content/raft-large-words.txt -s 200,301,307 -t 100 -u https://www.tesla.com




echo "[*]Finished Installing....[*]"