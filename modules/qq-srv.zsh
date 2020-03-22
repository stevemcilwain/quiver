#!/usr/bin/env zsh

############################################################# 
# qq-srv
#############################################################

qq-srv-web() print -z "sudo python3 -m http.server 80"
qq-srv-ftp() print -z "sudo python3 -m pyftpdlib -p 21 -w"
qq-srv-smb() print -z "sudo impacket-smbserver -smb2supp F ."
qq-srv-tftp() print -z "sudo service atftpd start"
qq-srv-smtp() print -z "sudo python -m smtpd -c DebuggingServer -n 0.0.0.0:25"

qq-srv-web-auto() {
    if [ "$#" -eq  "1" ]
    then
        pushd /srv; sudo python3 -m http.server $1; popd;
    else
        pushd /srv; sudo python3 -m http.server 80; popd;
    fi
}
alias srv-web="qq-srv-web-auto"

qq-srv-php-auto() {
    if [ "$#" -eq  "1" ]
    then
        pushd /srv; sudo php -S 0.0.0.0:$1; popd;
    else
        pushd /srv; sudo php -S 0.0.0.0:80; popd;
    fi
}
alias srv-php="qq-srv-php-auto"

qq-srv-ftp-auto() {
    pushd /srv
    sudo python3 -m pyftpdlib -p 21 -w
    popd
}
alias srv-ftp="qq-srv-ftp-auto"

qq-srv-updog() {
    print -z "updog -p 443 --ssl -p $(__rand 10)"
}

qq-srv-updog-auto() {
    updog -p 443 --ssl -d /srv
}
alias srv-up