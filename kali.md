# Kali Linux

Installation and Config

### ZSH

```bash
sudo apt-get install zsh -y

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

```

* customize .zshrc and source it

## Kali Meta Packages

```bash

sudo apt-get install -y \
kali-tools-information-gathering \
kali-tools-vulnerability \
kali-tools-web \
kali-tools-database \
kali-tools-passwords \
#kali-tools-wireless
#kali-tools-reverse-engineering
kali-tools-exploitation \
kali-tools-social-engineering \
#kali-tools-sniffing-spoofing
kali-tools-post-exploitation \
#kali-tools-forensics
#kali-tools-reporting
#kali-tools-gpu
#kali-tools-hardware
kali-tools-crypto-stego \
kali-tools-fuzzing \
#kali-tools-802-11
#kali-tools-bluetooth
#kali-tools-rfid
#kali-tools-sdr
#kali-tools-voip
kali-tools-windows-resources \
#kali-linux-large
#kali-linux-everything
kali-tools-top10

```

## Custom Packages

```bash

sudo apt-get install -y rlwrap xclip jq pigz fonts-powerline git unzip asciinema
sudo apt-get install -y gobuster exiftool amass lftp wireshark

```

## 32-Bit Packages

```bash

sudo dpkg --add-architecture i386
sudo apt-get update

```

## Dev Packages

```bash

sudo apt-get install python-pip python3-pip python-smb python3-pyftpdlib
sudo apt-get install gcc-multilib g++-multilib php-curl
sudo apt-get install mingw-w64 wine winetricks winbind

```

## Wine Config 

```bash

wine cmd.exe /c dir
winetricks cmake
winetricks python27
wine pip.exe install pyinstaller
wine pyinstaller.exe -v

```

## Go Packages

```bash

sudo apt-get install -y golang

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export GO111MODULE=on

go get -v github.com/projectdiscovery/subfinder/cmd/subfinder
go get github.com/charmbracelet/glow
go get github.com/tomnomnom/httprobe
go get github.com/michenriksen/gitrob
go get github.com/ffuf/ffuf

```

## Repos

```bash

# Wordlists

sudo gunzip -q -k /usr/share/wordlists/rockyou.txt.gz

sudo git clone https://github.com/chrislockard/api_wordlist.git /opt/words/api_wordlist
sudo git clone https://github.com/assetnote/commonspeak2-wordlists.git /opt/words/commonspeak2-wordlists
sudo git clone https://github.com/tarahmarie/nerdlist.git /opt/words/nerdlist
sudo wget -nd -P /opt/words/crackstation https://crackstation.net/files/crackstation-human-only.txt.gz
sudo gunzip /opt/words/crackstation/crackstation-human-only.txt.gz

sudo wget -nd -P /opt/words/all https://gist.githubusercontent.com/jhaddix/f64c97d0863a78454e44c2f7119c2a6a/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt

# Recon

sudo git clone https://github.com/smicallef/spiderfoot.git /opt/recon/spiderfoot
sudo pip install -r requirements.txt 

sudo git clone https://github.com/M4cs/BlackEye-Python.git /opt/recon/BlackEye-Python

#sniper

# Enum

sudo git clone https://github.com/ticarpi/jwt_tool.git /opt/enum/jwt_tool
sudo git clone https://github.com/s0md3v/Arjun.git /opt/enum/Arjun

# Privesc

sudo git clone https://github.com/rebootuser/LinEnum.git /opt/privesc/LinEnum
sudo git clone https://github.com/jondonas/linux-exploit-suggester-2.git /opt/privesc/linux-exploit-suggester-2
sudo git clone https://github.com/diego-treitos/linux-smart-enumeration.git /opt/privesc/linux-smart-enumeration
sudo git clone https://github.com/bitsadmin/wesng.git /opt/privesc/wesng
sudo git clone https://github.com/411Hall/JAWS.git /opt/privesc/JAWS

sudo wget -nd -P /opt/privesc/beroot https://github.com/AlessandroZ/BeRoot/releases/download/1.0.1/beRoot.zip
sudo unzip /opt/privesc/beroot/beRoot.zip -d /opt/privesc/beroot


# Exploits

sudo git clone https://github.com/SecWiki/linux-kernel-exploits.git /opt/exploit/linux-kernel-exploits
sudo git clone https://github.com/SecWiki/windows-kernel-exploits.git /opt/exploit/windows-kernel-exploits
sudo git clone https://github.com/m4ll0k/AutoNSE /opt/exploit/AutoNSE
sudo git clone https://github.com/3ndG4me/AutoBlue-MS17-010.git /opt/exploit/AutoBlue
sudo git clone https://github.com/abatchy17/WindowsExploits.git /opt/exploit/WindowsExploits

# Post

sudo wget -nd -P /opt/privesc/accesschk https://web.archive.org/web/20071007120748if_/http://download.sysinternals.com/Files/Accesschk.zip
sudo unzip /opt/privesc/accesschk/Accesschk.zip -d /opt/privesc/accesschk

sudo wget -r -P /opt/post/sysinternals http://live.sysinternals.com/

sudo git clone https://github.com/M4ximuss/Powerless.git /opt/post/powerless

```

## XFCE

```bash

sudo apt-get install kali-desktop-xfce

```

## Metasploit Prep

```bash
sudo systemctl start postgresql 
sudo systemctl enable postgresql 
sudo msfdb init 
```

## Firewall

Enable the UFW firewall to only allow incoming SSH connections.

```bash

 sudo ufw allow OpenSSH
 sudo ufw enable
 sudo ufw status numbered

```

# Setup Hosting

```bash

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

```

