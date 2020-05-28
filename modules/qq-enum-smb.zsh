#!/usr/bin/env zsh

############################################################# 
# qq-enum-smb
#############################################################

qq-enum-smb-help() {
  cat << "DOC"

qq-enum-smb
------------
The qq-enum-smb namespace contains commands for scanning
and enumerating smb services.

Commands
--------
qq-enum-smb-install:                  installs dependencies
qq-enum-smb-nmap-sweep:               scan a network for services
qq-enum-smb-tcpdump:                  capture traffic to and from a host
qq-enum-smb-null-smbmap:              query with smbmap null session
qq-enum-smb-user-smbmap:              query with smbmap authenticated session
qq-enum-smb-null-enum4:               enumerate with enum4linux
qq-enum-smb-null-smbclient-list:      list shares with a null session
qq-enum-smb-null-smbclient-connect:   connect with a null session
qq-enum-smb-user-smbclient-connect:   connect with an authenticated session
qq-enum-user-smb-mount:               mount an SMB share
qq-enum-smb-samrdump:                 dump info using impacket
qq-enum-smb-responder:                spoof and get responses using responder
qq-enum-smb-net-use-null:             print a net use statement for windows
qq-enum-smb-nbtscan:                  scan a local network 
qq-enum-smb-rpcclient:                use rcpclient for queries

DOC
}

qq-enum-smb-install() {
    __pkgs nmap tcpdump smbmap enum4linux smbclient impacket-scripts responder nbtscan rpcclient
}

qq-enum-smb-nmap-sweep() {
  __check-project
  qq-vars-set-network
  print -z "nmap -n -Pn -sS -sU -p445,137-139 ${__NETWORK} -oA $(__netpath)/smb-sweep"
}

qq-enum-smb-tcpdump() {
  __check-project
  qq-vars-set-iface
  qq-vars-set-rhost
  print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 445 -w $(__hostpath)/smb.pcap"
}

qq-enum-smb-null-smbmap() {
  qq-vars-set-rhost
  print -z "smbmap -H ${__RHOST}"
}

qq-enum-smb-user-smbmap() {
  qq-vars-set-rhost
  __check-user
  __info "Usage with creds: -u <user> -p <pass> -d <domain>"
  print -z "smbmap -u ${__USER} -H ${__RHOST}"
}

qq-enum-smb-null-enum4() {
  qq-vars-set-rhost
  print -z "enum4linux -a ${__RHOST} | tee $(__hostpath)/enum4linux.txt "
}

qq-enum-smb-null-smbclient-list() {
  qq-vars-set-rhost
  print -r -z "smbclient -L \\\\\\\\${__RHOST} -N "
}

qq-enum-smb-null-smbclient-connect() {
  qq-vars-set-rhost
  __check-share
  print -r -z "smbclient \\\\\\\\${__RHOST}\\\\${__SHARE} -N "
}

qq-enum-smb-user-smbclient-connect() {
  qq-vars-set-rhost
  __check-user
  __check-share
  print -r -z "smbclient \\\\\\\\${__RHOST}\\\\${__SHARE} -U ${__USER} "
}

qq-enum-user-smb-mount() {
  qq-vars-set-rhost
  __check-user
  local p && __askvar p PASSWORD
  __check-share
  print -z "mount //${__RHOST}/${__SHARE} /mnt/${__SHARE} -o username=${__USER},password=${p}"
}

qq-enum-smb-samrdump() {
  qq-vars-set-rhost
  print -z "python3 ${__IMPACKET}/samrdump.py ${__RHOST}"
}

qq-enum-smb-responder() {
  qq-vars-set-iface
  print -z "responder -I ${__IFACE} -A"
}

qq-enum-smb-net-use-null() {
    qq-vars-set-rhost
  __info "net use \\\\\\\\${__RHOST}\\IPC$ \"\" /u:\"\" "
}

qq-enum-smb-nbtscan() {
  qq-vars-set-network
  print -z "nbtscan ${__NETWORK}"
}

qq-enum-smb-rpcclient() {
  qq-vars-set-rhost
  print -z "rpcclient -U \" \" ${__RHOST}"
}