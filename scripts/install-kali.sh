#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

echo -e "[*] install-kali.sh "
echo -e " "

echo -e "${green}[+] Updating...${reset}"

sudo apt-get update
sudo apt-get full-upgrade -y 
sudo apt-get autoremove -y 

echo -e "${green}[+] Installing meta-packages...${reset}"

sudo apt-get install -y \
kali-tools-information-gathering \
kali-tools-vulnerability \
kali-tools-web \
kali-tools-database \
kali-tools-passwords \
kali-tools-wireless \
kali-tools-reverse-engineering \
kali-tools-exploitation \
kali-tools-social-engineering \
kali-tools-sniffing-spoofing \
kali-tools-post-exploitation \
kali-tools-crypto-stego \
kali-tools-fuzzing \
kali-tools-802-11 \
kali-tools-windows-resources \
kali-tools-top10

#kali-tools-bluetooth
#kali-tools-rfid
#kali-tools-sdr
#kali-tools-voip
#kali-linux-large
#kali-linux-everything
#kali-tools-forensics
#kali-tools-reporting
#kali-tools-gpu
#kali-tools-hardware

echo -e "${green}[+] Adding ZSH and Oh-My-ZSH...${reset}"

sudo apt-get install zsh -y
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo -e "${green}[+] Add XFCE and XRDP...${reset}"

sudo apt-get install kali-desktop-xfce xrdp -y
echo "exec startxfce4" | sudo tee -a /etc/xrdp/xrdp.ini
sudo service xrdp restart 

echo -e "${green}[+] Installing custom packages...${reset}"

sudo apt-get install -y rlwrap xclip jq pigz fonts-powerline git unzip asciinema 
sudo apt-get install -y gobuster exiftool amass lftp wireshark impacket-scripts

echo -e "${green}[+] Installing golang and packages... ${reset}"

sudo apt-get install -y golang

echo "export GOPATH=\$HOME/go" | tee -a .zshrc
echo "export PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin" | tee -a .zshrc
echo "export GO111MODULE=on" | tee -a .zshrc

go get -v -u github.com/projectdiscovery/subfinder/cmd/subfinder
go get -v -u github.com/charmbracelet/glow
go get -v -u github.com/tomnomnom/httprobe
go get -v -u github.com/michenriksen/gitrob
go get -v -u github.com/ffuf/ffuf

echo -e "${green}[+] Adding 32 bit architecture...${reset}"

sudo dpkg --add-architecture i386 
sudo apt-get update

echo -e "${green}[+] Adding dev tools...${reset}"

sudo apt-get install python python3 python-pip python3-pip python-smb python3-pyftpdlib
sudo apt-get install gcc-multilib g++-multilib php-curl
sudo apt-get install mingw-w64 wine winetricks winbind

echo -e "${green}[+] Adding wordlists...${reset}"

sudo gunzip -q -k /usr/share/wordlists/rockyou.txt.gz

sudo git clone https://github.com/chrislockard/api_wordlist.git /opt/words/api_wordlist
sudo git clone https://github.com/assetnote/commonspeak2-wordlists.git /opt/words/commonspeak2-wordlists
sudo git clone https://github.com/tarahmarie/nerdlist.git /opt/words/nerdlist
sudo wget -nd -P /opt/words/crackstation https://crackstation.net/files/crackstation-human-only.txt.gz
sudo gunzip /opt/words/crackstation/crackstation-human-only.txt.gz

sudo wget -nd -P /opt/words/all https://gist.githubusercontent.com/jhaddix/f64c97d0863a78454e44c2f7119c2a6a/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt

echo -e "${green}[+] Adding recon tools...${reset}"

sudo git clone https://github.com/smicallef/spiderfoot.git /opt/recon/spiderfoot
sudo git clone https://github.com/M4cs/BlackEye-Python.git /opt/recon/BlackEye-Python

sudo git clone https://github.com/guelfoweb/knock.git /opt/recon/knock
sudo python /opt/recon/knock/setup.py install


echo -e "${green}[+] Adding enum tools...${reset}"

sudo git clone https://github.com/ticarpi/jwt_tool.git /opt/enum/jwt_tool
sudo git clone https://github.com/s0md3v/Arjun.git /opt/enum/Arjun
sudo git clone https://github.com/tarunkant/EndPoint-Finder.git /opt/enum/Endpoint-Finder

echo -e "${green}[+] Adding privesc tools...${reset}"

sudo git clone https://github.com/rebootuser/LinEnum.git /opt/privesc/LinEnum
sudo git clone https://github.com/jondonas/linux-exploit-suggester-2.git /opt/privesc/linux-exploit-suggester-2
sudo git clone https://github.com/diego-treitos/linux-smart-enumeration.git /opt/privesc/linux-smart-enumeration
sudo git clone https://github.com/bitsadmin/wesng.git /opt/privesc/wesng
sudo git clone https://github.com/411Hall/JAWS.git /opt/privesc/JAWS
sudo wget -nd -P /opt/privesc/beroot https://github.com/AlessandroZ/BeRoot/releases/download/1.0.1/beRoot.zip
sudo unzip /opt/privesc/beroot/beRoot.zip -d /opt/privesc/beroot

echo -e "${green}[+] Adding exploit tools...${reset}"

sudo git clone https://github.com/SecWiki/linux-kernel-exploits.git /opt/exploit/linux-kernel-exploits
sudo git clone https://github.com/SecWiki/windows-kernel-exploits.git /opt/exploit/windows-kernel-exploits
sudo git clone https://github.com/m4ll0k/AutoNSE /opt/exploit/AutoNSE
sudo git clone https://github.com/3ndG4me/AutoBlue-MS17-010.git /opt/exploit/AutoBlue
sudo git clone https://github.com/abatchy17/WindowsExploits.git /opt/exploit/WindowsExploits

echo -e "${green}[+] Adding post exploit tools...${reset}"

sudo wget -nd -P /opt/privesc/accesschk https://web.archive.org/web/20071007120748if_/http://download.sysinternals.com/Files/Accesschk.zip
sudo unzip /opt/privesc/accesschk/Accesschk.zip -d /opt/privesc/accesschk
sudo wget -r -P /opt/post/sysinternals http://live.sysinternals.com/
sudo git clone https://github.com/M4ximuss/Powerless.git /opt/post/powerless

echo -e "${green}[+] Metasploit prep...${reset}"

sudo service postgresql start  
sudo msfdb init 

echo -e "${green}[+] Installing UFW...${reset}"

sudo apt-get install ufw -y 
sudo ufw allow OpenSSH

echo -e "${green}[+] Adding /srv hosting...${reset}"

sudo mkdir /srv/linux

sudo ln -s /opt/LinEnum/LinEnum.sh /srv/linux/linenum.sh
sudo ln -s /usr/share/unix-privesc-check/unix-privesc-check /srv/linux/upc
sudo ln -s /opt/linux-exploit-suggester-2/ /srv/linux/les2.pl
sudo ln -s /opt/linux-smart-enumeration/lse.sh /srv/linux/lse.sh

sudo mkdir /srv/windows

sudo ln -s /opt/accesschk/accesschk.exe /srv/windows/accesschk.exe
sudo ln -s /opt/sysinternals/ /srv/windows/sysinternals
sudo ln -s /usr/share/windows-resources/powersploit/ /srv/windows/powersploit
sudo ln -s /usr/share/nishang/ /srv/windows/nishang
sudo ln -s /opt/JAWS/jaws-enum.ps1 /srv/windows/jaws.ps1
sudo ln -s /usr/share/windows-resources/binaries/nc.exe /srv/windows/nc.exe
sudo ln -s /opt/beroot/beRoot.exe /srv/windows/beroot.exe
sudo ln -s /usr/share/windows-resources/mimikatz/ /srv/windows/mimikatz
sudo ln -s /opt/powerless/Powerless.bat /srv/windows/pless.bat

sudo mkdir /srv/rfi
echo "<html><body><p>PHP INFO PAGE</p><br /><?php phpinfo(); ?></body></html>" | sudo tee /srv/rfi/phpinfo.php

echo -e "${green}[+] Adding samba server...${reset}"

