#!/usr/bin/env zsh

############################################################# 
# qq-install
#############################################################





qq-install-git-pull-tools() {
  print -z "cd ${__TOOLS}; for d in \$(ls -d */);do cd \$d && git pull && cd - ; done; cd"
}

qq-install-all() {
  #qq-aliases-install
  qq-bounty-install
  #qq-encoding-install
  qq-enum-dhcp-install
  qq-enum-dns-install
  qq-enum-ftp-install
  qq-enum-host-install
  qq-enum-kerb-install
  qq-enum-ldap-install
  qq-enum-mssql-install
  qq-enum-mysql-install
  qq-enum-network-install
  qq-enum-nfs-install
  qq-enum-oracle-install
  qq-enum-pop3-install
  qq-enum-rdp-install
  qq-enum-smb-install
  qq-enum-web-aws-install
  qq-enum-web-dirs-install
  qq-enum-web-elastic-install
  
  qq-enum-web-vuln-install
  qq-enum-web-ssl-install
  qq-enum-web-install
  qq-notes-install
  qq-log-install
  qq-exploit-install
  qq-pivot-install
  qq-recon-domains-install
  qq-recon-github-install
  qq-recon-networks-install
  qq-recon-org-install
  qq-recon-subs-install
  qq-shell-handlers-msf-install
  qq-shell-handlers-install
  #qq-shell-handlers-tty-install
  qq-srv-install

  
}









qq-install(){
 
  __info "Installing apt packages... " 

  __pkgs jq netcat pigz fonts-powerline unzip asciinema tmux dtach tree

  __pkgs python3 python3-pip php php-curl libldns-dev libssl-dev libcurl4-openssl-dev 
  
  __pkgs jsbeautifier npm

  __pkgs   exiftool     


  __pkgs  john 

  __pkgs metasploit-framework exploitdb

  __info "Installing node packages"

  sudo npm install --global n
  sudo npm install --global eslint

  __info "Installing python packages... "

  sudo pip install wfuzz
 
  
  go get -v -u github.com/tomnomnom/gron

  go get -v -u github.com/tomnomnom/meg
  go get -v -u github.com/tomnomnom/hacks/filter-resolved
  go get -v -u github.com/tomnomnom/hacks/html-tool
  go get -v -u github.com/tomnomnom/hacks/inscope
  go get -v -u github.com/tomnomnom/hacks/mirror
 

 
  
  __info "Installing enum repos... "

  sudo git clone https://github.com/tarunkant/EndPoint-Finder.git /opt/enum/Endpoint-Finder

 

 
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

qq-install-wordlist-nerdlist() {
  local name="nerdlist"
  local url="https://github.com/tarahmarie/nerdlist.git"
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

qq-install-s3scanner() {
  local name="S3Scanner"
  local url="https://github.com/sa7mon/S3Scanner.git"
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

qq-install-nmap-elasticsearch-nse() {
  local name="nmap-elasticsearch-nse"
  local url="https://github.com/theMiddleBlue/nmap-elasticsearch-nse.git"
  local p="$__TOOLS/$name"

   __info "$name"

  if [[ ! -d $p ]]
  then
    git clone $url $p

    #after commands
    pushd $p
    sudo cp elasticsearch.nse /usr/share/nmap/scripts/
    popd

  else
    __warn "already installed in $p"
    pushd $p 
    git pull
    sudo cp elasticsearch.nse /usr/share/nmap/scripts/
    popd
  fi
}

