#!/usr/bin/env zsh

############################################################# 
# qq-install
#############################################################

qq-install(){

  __info "Installing apt packages... "

  __pkgs rlwrap jq curl wget netcat pigz fonts-powerline unzip asciinema

  __pkgs python python3 python-pip python3-pip python-smb python3-pyftpdlib php php-curl libldns-dev 

  __pkgs nmap masscan tcpdump awscli exiftool lftp whois 

  __pkgs whatweb gobuster wpscan wafw00f wfuzz hydra nikto padbuster parsero dirb 

  __pkgs metagoofil cewl john theharvester eyewitness amass sublist3r dnsrecon 

  __pkgs impacket-scripts atftpd wordlists seclists 

  __info "Installing python packages... "

  pip install py-altdns

  __info "Installing golang and packages... "

  __install_golang
  go get -v -u github.com/projectdiscovery/subfinder/cmd/subfinder 
  go get -v -u github.com/charmbracelet/glow
  go get -v -u github.com/tomnomnom/httprobe
  go get -v -u github.com/michenriksen/gitrob
  go get -v -u github.com/ffuf/ffuf

  __info "Installing wordlist repos... "

  sudo git clone https://github.com/chrislockard/api_wordlist.git /opt/words/api_wordlist
  sudo git clone https://github.com/assetnote/commonspeak2-wordlists.git /opt/words/commonspeak2-wordlists
  sudo git clone https://github.com/tarahmarie/nerdlist.git /opt/words/nerdlist
  sudo wget -nd -P /opt/words/all https://gist.githubusercontent.com/jhaddix/f64c97d0863a78454e44c2f7119c2a6a/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt
  sudo gunzip -q -k /usr/share/wordlists/rockyou.txt.gz

  __info "Installing recon repos... "

  sudo git clone https://github.com/blechschmidt/massdns.git /opt/recon/massdns
  cd /opt/recon/massdns
  sudo make
  cd -

  sudo git clone https://github.com/gwen001/github-search.git /opt/recon/github-search
  cd /opt/recon/github-search
  sudo pip3 install -r requirements.txt
  cd -

  sudo git clone https://github.com/guelfoweb/knock.git /opt/recon/knock
  cd /opt/recon/knock
  sudo python setup.py install
  cd -

  __info "Installing enum repos... "

  sudo git clone https://github.com/tarunkant/EndPoint-Finder.git /opt/enum/Endpoint-Finder

  sudo git clone https://github.com/sa7mon/S3Scanner.git /opt/enum/S3Scanner
  cd /opt/enum/S3Scanner
  sudo pip install -r requirements.txt
  cd -

  sudo git clone https://github.com/guelfoweb/knock.git /opt/recon/knock
  cd /opt/recon/knock
  sudo python setup.py install
  cd -

  sudo git clone https://github.com/blechschmidt/massdns.git /opt/recon/massdns
  cd /opt/recon/massdns
  sudo make
  cd -

  sudo git clone https://github.com/gwen001/github-search.git /opt/recon/github-search
  cd /opt/recon/github-search
  sudo pip3 install -r requirements.txt
  cd -

  __info "Installation completed "

}

# helpers

__pkgs(){
  echo "  [+] check for and installing dependencies..."
  for pkg in "$@"
  do
      dpkg -l | grep -qw $pkg || sudo apt-get -y install $pkg
  done 
}

__install_golang() {

  sudo apt-get install golang -y

  echo "export GOPATH=\$HOME/go" | tee -a .zshrc
  echo "export PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin" | tee -a .zshrc
  echo "export GO111MODULE=on" | tee -a .zshrc

  export GOPATH=$HOME/go
  export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

}