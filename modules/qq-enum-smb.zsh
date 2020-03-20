#!/usr/bin/env zsh

############################################################# 
# qq-enum-smb
#############################################################

qq-enum-smb-sweep-nmap() {
  qq-vars-set-network
  print -z "nmap -n -Pn -sS -sU -p445,137-139 ${__NETWORK} -oA $(__netpath)/smb-sweep"
}

qq-enum-smb-tcpdump() {
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
  local u && read "u?$fg[cyan]USER:$reset_color "
  __info "Usage with creds: -u <user> -p <pass> -d <domain>"
  print -z "smbmap -u ${u} -H ${__RHOST}"
}

qq-enum-smb-null-enum4() {
  qq-vars-set-rhost
  print -z "enum4linux -a ${__RHOST}"
}

qq-enum-smb-null-smbclient-list() {
  qq-vars-set-rhost
  print -r -z "smbclient -L \\\\\\\\${__RHOST} -N "
}

qq-enum-smb-null-smbclient-connect() {
  qq-vars-set-rhost
  local share && read "share?$fg[cyan]SHARE:$reset_color "
  print -r -z "smbclient \\\\\\\\${__RHOST}\\\\${share} -N "
}

qq-enum-smb-user-smbclient-connect() {
  qq-vars-set-rhost
  local u && read "u?$fg[cyan]USER:$reset_color "
  local share && read "share?$fg[cyan]SHARE:$reset_color "
  print -r -z "smbclient \\\\\\\\${__RHOST}\\\\${share} -U ${u} "
}

qq-enum-user-smb-mount() {
  qq-vars-set-rhost
  local share && read "share?$fg[cyan]SHARE:$reset_color "
  local u && read "u?$fg[cyan]USER:$reset_color "
  local p && read "p?$fg[cyan]PASSWORD:$reset_color "
  print -z "mount //${__RHOST}/${share} /mnt/${share} -o username=${u},password=${p}"
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

qq-enum-smb-bluecheck() {
  qq-vars-set-rhost
  print -z "nmap -Pn -p445 --open --max-hostgroup 3 --script smb-vuln-ms17-010 ${__RHOST}"
}
