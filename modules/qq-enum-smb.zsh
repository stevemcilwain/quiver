#!/usr/bin/env zsh

############################################################# 
# qq-enum-smb
#############################################################

qq-enum-smb-sweep-nmap() {
  local s && read "s?SUBNET: "
  print -z "nmap -n -Pn -sS -sU -p445,137-139 -oA smb_sweep ${s} &&  grep open smb_sweep.gnmap |cut -d' ' -f2 > smb_hosts.txt"
}

qq-enum-smb-tcpdump() {
  __info "Available: ${__IFACES}"
  local i && read "i?IFACE: "
  local r && read "r?RHOST: "
  print -z "tcpdump -i ${i} host ${r} and tcp port 445 -w smb.${r}.pcap"
}

qq-enum-smb-null-smbmap() {
  local r && read "r?RHOST: "
  print -z "smbmap -H ${r}"
}

qq-enum-smb-user-smbmap() {
  local r && read "r?RHOST: "
  local u && read "u?USER: "
  __info "Usage with creds: -u <user> -p <pass> -d <domain>"
  print -z "smbmap -u ${u} -H ${r}"
}

qq-enum-smb-null-enum4() {
  local r && read "r?RHOST: "
  print -z "enum4linux -a ${r}"
}

qq-enum-smb-null-smbclient-list() {
  local r && read "r?RHOST: "
  print -r -z "smbclient -L \\\\\\\\${r} -N "
}

qq-enum-smb-null-smbclient-connect() {
  local r && read "r?RHOST: "
  local share && read "share?SHARE: "
  print -r -z "smbclient \\\\\\\\${r}\\\\${share} -N "
}

qq-enum-smb-user-smbclient-connect() {
  local r && read "r?RHOST: "
  local u && read "u?USER: "
  local share && read "share?SHARE: "
  print -r -z "smbclient \\\\\\\\${r}\\\\${share} -U ${u} "
}

qq-enum-user-smb-mount() {
  local r && read "r?RHOST: "
  local share && read "share?SHARE: "
  local u && read "u?USER: "
  local p && read "p?PASSWORD: "
  print -z "mount //${r}/${share} /mnt/${share} -o username=${u},password=${p}"
}

qq-enum-smb-samrdump() {
  local r && read "r?RHOST: "
  print -z "python3 ${__IMPACKET}/samrdump.py ${r}"
}

qq-enum-smb-responder() {
  __info "Available: ${__IFACES}"
  local i && read "i?IFACE: "
  print -z "responder -I ${i} -A"
}

qq-enum-smb-net-use-null() {
  __info "net use \\\\\\\\<server>\\IPC$ \"\" /u:\"\" "
}

qq-enum-smb-bluecheck() {
  local r && read "r?RHOST: "
  print -z "nmap -Pn -p445 --open --max-hostgroup 3 --script smb-vuln-ms17-010 ${r}"
}
