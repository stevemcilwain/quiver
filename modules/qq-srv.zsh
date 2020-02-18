#!/usr/bin/env zsh

############################################################# 
# qq-srv
#############################################################

qq-srv-web() print -z "sudo python3 -m http.server 80"
qq-srv-ftp() print -z "sudo python3 -m pyftpdlib -p 21 -w"
qq-srv-smb() print -z "sudo impacket-smbserver -smb2supp F ."
qq-srv-tftp() print -z "sudo service atftpd start"
qq-srv-smtp() print -z "sudo python -m smtpd -c DebuggingServer -n 0.0.0.0:25"
