#!/usr/bin/env zsh

############################################################# 
# qq-enum-smb
#############################################################

qq-enum-smb-sweep-nmap() {
  __GET-NETWORK
  print -z "nmap -n -Pn -sS -sU -p445,137-139 ${__NETWORK}"
}

qq-enum-smb-tcpdump() {
  __GET-IFACE
  __GET-RHOST
  print -z "tcpdump -i ${__IFACE} host ${__RHOST} and tcp port 445"
}

qq-enum-smb-null-smbmap() {
  __GET-RHOST
  print -z "smbmap -H ${__RHOST}"
}

qq-enum-smb-user-smbmap() {
  __GET-RHOST
  local u && read "u?USER: "
  __info "Usage with creds: -u <user> -p <pass> -d <domain>"
  print -z "smbmap -u ${u} -H ${__RHOST}"
}

qq-enum-smb-null-enum4() {
  __GET-RHOST
  print -z "enum4linux -a ${__RHOST}"
}

qq-enum-smb-null-smbclient-list() {
  __GET-RHOST
  print -r -z "smbclient -L \\\\\\\\${__RHOST} -N "
}

qq-enum-smb-null-smbclient-connect() {
  __GET-RHOST
  local share && read "share?SHARE: "
  print -r -z "smbclient \\\\\\\\${__RHOST}\\\\${share} -N "
}

qq-enum-smb-user-smbclient-connect() {
  __GET-RHOST
  local u && read "u?USER: "
  local share && read "share?SHARE: "
  print -r -z "smbclient \\\\\\\\${__RHOST}\\\\${share} -U ${u} "
}

qq-enum-user-smb-mount() {
  __GET-RHOST
  local share && read "share?SHARE: "
  local u && read "u?USER: "
  local p && read "p?PASSWORD: "
  print -z "mount //${__RHOST}/${share} /mnt/${share} -o username=${u},password=${p}"
}

qq-enum-smb-samrdump() {
  __GET-RHOST
  print -z "python3 ${__IMPACKET}/samrdump.py ${__RHOST}"
}

qq-enum-smb-responder() {
  __GET-IFACE
  print -z "responder -I ${__IFACE} -A"
}

qq-enum-smb-net-use-null() {
    __GET-RHOST
  __info "net use \\\\\\\\${__RHOST}\\IPC$ \"\" /u:\"\" "
}

qq-enum-smb-bluecheck() {
  __GET-RHOST
  print -z "nmap -Pn -p445 --open --max-hostgroup 3 --script smb-vuln-ms17-010 ${__RHOST}"
}
