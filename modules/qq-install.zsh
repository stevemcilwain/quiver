#!/usr/bin/env zsh

############################################################# 
# qq-install
#############################################################

qq-install(){
 
  __info "Installing apt packages... " 

  __pkgs jq curl wget netcat pigz fonts-powerline unzip asciinema dnsutils tmux dtach sshfs tree

  __pkgs python python3 python-pip python3-pip python-smb python3-pyftpdlib php php-curl libldns-dev libssl-dev libcurl4-openssl-dev 
  
  __pkgs jsbeautifier npm

  __pkgs nmap masscan tcpdump awscli exiftool tftp ftp lftp whois 

  __pkgs whatweb gobuster wpscan wafw00f hydra nikto padbuster parsero dirb 

  __pkgs  john eyewitness amass sublist3r dnsrecon 

  __pkgs  wordlists seclists 

  __pkgs metasploit-framework exploitdb

  __info "Installing node packages"

  sudo npm install --global n
  sudo npm install --global eslint

  __info "Installing python packages... "

  sudo pip install wfuzz
 
  __info "Installing golang and packages... "

  __install_golang


  go get -v -u github.com/tomnomnom/httprobe
  go get -v -u github.com/ffuf/ffuf
  
  
  go get -v -u github.com/tomnomnom/gron

  go get -v -u github.com/tomnomnom/meg
  go get -v -u github.com/tomnomnom/hacks/filter-resolved
  go get -v -u github.com/tomnomnom/hacks/html-tool
  go get -v -u github.com/tomnomnom/hacks/inscope
  go get -v -u github.com/tomnomnom/hacks/mirror
 

  __info "Installing wordlist repos... "

  sudo git clone https://github.com/chrislockard/api_wordlist.git /opt/words/api_wordlist
 
  sudo git clone https://github.com/tarahmarie/nerdlist.git /opt/words/nerdlist
  sudo wget -nd -P /opt/words/nullenc https://gist.github.com/stevemcilwain/f875b42ddb51c6eec5207f21a92cdceb/raw/146f367110973250785ced348455dc5173842ee4/content_discovery_nullenc0de.txt
  sudo wget -nd -P /opt/words/all https://gist.githubusercontent.com/jhaddix/f64c97d0863a78454e44c2f7119c2a6a/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt
  sudo gunzip -q -k /usr/share/wordlists/rockyou.txt.gz

 
  
  __info "Installing enum repos... "

  sudo git clone https://github.com/tarunkant/EndPoint-Finder.git /opt/enum/Endpoint-Finder

  sudo git clone https://github.com/sa7mon/S3Scanner.git /opt/enum/S3Scanner
  cd /opt/enum/S3Scanner
  sudo pip install -r requirements.txt
  cd -

 
  sudo git clone https://github.com/GerbenJavado/LinkFinder.git /opt/enum/LinkFinder
  cd /opt/enum/LinkFinder
  sudo python setup.py install
  
  __info "Installation completed "

}

__addpath() {
  echo "export PATH=\$PATH:$1" | tee -a ~/.zshrc
  export PATH=$PATH:$1
}

__pkgs(){
  __info "checking for and installing dependencies..."
  for pkg in "$@"
  do
    __info "$pkg"
      dpkg -l | grep -qw $pkg && __warn "already installed" || sudo apt-get -y install $pkg
  done 
}

qq-install-golang() {

  __pkgs golang

  if [[ -z "GOPATH" ]]
  then
    echo "export GOPATH=\$HOME/go" | tee -a .zshrc
    echo "export PATH=\$PATH:/usr/local/go/bin:\$GOPATH/bin" | tee -a .zshrc
    #echo "export GO111MODULE=on" | tee -a .zshrc
    export GOPATH=$HOME/go
    export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
  fi 
}

# Repos

qq-install-wordlist-commonspeak() {
  local name="commonspeak2"
  local url="https://github.com/assetnote/commonspeak2-wordlists.git"
  local p="$__TOOLS/$name"

  __info "$name"
 
  if [[ ! -d $p ]]
  then
    git clone $url $p
  else
    __warn "already installed in $p"
    pushd $p 
    git pull
    popd
  fi
   
}

qq-install-massdns() {
  local name="massdns"
  local url="https://github.com/blechschmidt/massdns.git"
  local p="$__TOOLS/$name"

   __info "$name"

  if [[ ! -d $p ]]
  then
    git clone $url $p

    #after commands
    pushd $p
    make
    popd
    __addpath $p/bin

  else
    __warn "already installed in $p"
    pushd $p 
    git pull
    make
    popd
  fi
}

qq-install-github-search() {
  local name="github-search"
  local url="https://github.com/gwen001/github-search.git"
  local p="$__TOOLS/$name"

   __info "$name"

  if [[ ! -d $p ]]
  then
    git clone $url $p

    #after commands
    pushd $p
    pip3 install -r requirements.txt
    popd
    __addpath $p

  else
    __warn "already installed in $p"
    pushd $p 
    git pull
    pip3 install -r requirements.txt
    popd
  fi
}

qq-install-gf() {
  local name="gf"

  __info "$name"

  go get -u github.com/tomnomnom/gf
  echo "source \$GOPATH/src/github.com/tomnomnom/gf/gf-completion.zsh" >> $HOME/.zshrc
  cp -r $GOPATH/src/github.com/tomnomnom/gf/examples $HOME/.gf

}

qq-install-git-secrets() {
  local name="git-secrets"
  local url="https://github.com/awslabs/git-secrets.git"
  local p="$__TOOLS/$name"

   __info "$name"

  if [[ ! -d $p ]]
  then 
    git clone $url $p

    #after commands
    pushd $p
    sudo make install
    popd
    __addpath $p

  else
    __warn "already installed in $p"
    pushd $p 
    git pull
    sudo make install
    popd
  fi
}

qq-install-gitrob() {

  local name="gitrob"

  __info "$name"

  go get -u github.com/golang/dep/cmd/dep
  go get -u github.com/codeEmitter/gitrob
  pushd ~/go/src/github.com/codeEmitter/gitrob
  dep ensure
  go build
  popd

}

qq-install-pentest-tools() {
  local name="pentest-tools"
  local url="https://github.com/gwen001/pentest-tools.git"
  local p="$__TOOLS/$name"

  __info "$name"

  if [[ ! -d $p ]]
  then
    git clone $url $p

    #after commands
    __addpath $p

  else
    __warn "already installed in $p"
    pushd $p 
    git pull
    popd
  fi
}

qq-install-protonvpn() {
  local name="protonvpn"
  __info "$name"

  sudo apt install -y openvpn dialog python3-pip python3-setuptools
  sudo pip3 install protonvpn-cli
  __warn "ProtonVPN username and password required"
  print -z "sudo protonvpn init"
}





